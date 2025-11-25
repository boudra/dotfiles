local M = {}

-- Shared state
local lru_buffers = {}

-- Function to update LRU buffer list
local function update_lru_buffers(buf)
  if vim.api.nvim_buf_get_option(buf, 'buftype') == '' and vim.fn.bufname(buf) ~= '' then
    -- Remove the buffer if it's already in the list
    for i, v in ipairs(lru_buffers) do
      if v == buf then
        table.remove(lru_buffers, i)
        break
      end
    end
    -- Add the buffer to the front of the list
    table.insert(lru_buffers, 1, buf)
    -- Keep only the 3 least recently used file buffers
    while #lru_buffers > 3 do
      table.remove(lru_buffers)
    end
  end
end

-- Helper function to get selected text
local function get_selected_text()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local start_col = vim.fn.col("'<")
  local end_col = vim.fn.col("'>")

  -- Get all lines in the selection
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    -- Adjust first and last lines of multi-line selection
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  local selected_text = table.concat(lines, "\n")
  local before_text = table.concat(vim.api.nvim_buf_get_lines(0, 0, start_line - 1, false), "\n")
  local after_text = table.concat(vim.api.nvim_buf_get_lines(0, end_line, -1, false), "\n")

  return selected_text, start_line, end_line, before_text, after_text
end

local function build_project_tree()
  local handle = io.popen("git ls-files")
  local output = handle:read("*a")
  handle:close()

  local root_path = vim.fn.getcwd()
  local tree = {}

  for path in output:gmatch("[^\r\n]+") do
    local parts = vim.split(path, "/")
    local current_level = tree

    for i = 1, #parts do
      local part = parts[i]

      if i == #parts then
        current_level[part] = true
      else
        if not current_level[part] then
          current_level[part] = {}
        end
        current_level = current_level[part]
      end
    end
  end

  local function print_tree(node, level, output_str)
    if not output_str then
      output_str = ""
    end
    for key, value in pairs(node) do
      local padding = string.rep(" ", level * 2)
      if type(value) == "table" then
        output_str = output_str .. padding .. "/" .. key .. "\n"
        output_str = print_tree(value, level + 1, output_str)
      else
        output_str = output_str .. padding .. "/" .. key .. "\n"
      end
    end
    return output_str
  end

  return print_tree(tree, 0)
end


-- Helper function to get project context
local function get_project_context()
  local project_context = "You are working on a project with the following structure:\n" ..
      build_project_tree() .. "\n\n"

  if #lru_buffers > 1 then
    project_context = "Here are some relevant files in the project:\n\n"
    for i = 2, #lru_buffers do
      local buf = lru_buffers[i]
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if vim.api.nvim_buf_is_valid(buf) then
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        project_context = project_context .. "File: " .. buf_name .. "\n"
        project_context = project_context ..
            "```\n" .. table.concat(lines, "\n") .. "```\n------------------------------------\n"
      end
    end
  end

  return project_context
end


-- Function to get system prompt
local function get_system_prompt()
  return "You are a helpful software engineer assistant.\n\n"
      .. "- Don't elide any code from your output.\n"
      .. "- Pay close attention to the context and where the code is placed.\n"
      .. "- When you are asked to operate on code, your message should contain only code, no other text or markdown.\n"
      .. "- Never wrap the code in backticks, just reply with the code.\n\n"
      .. get_project_context()
end

-- Function to update context.md
local function update_context_md(system_prompt, user_prompt)
  local context_md = "context.md"
  local file = io.open(context_md, "w")
  if file then
    file:write("# System Prompt\n\n")
    file:write(system_prompt)
    file:write("\n\n# User Prompt\n\n")
    file:write(user_prompt)
    file:close()
  end
end

local function use_api_response(response)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  if start_line == 0 and end_line == 0 then
    -- No selection, insert at current cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, vim.split(response, "\n"))
  else
    -- Replace selection
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, vim.split(response, "\n"))
    vim.fn.setpos("'<", { 0, start_line, 1, 0 })
    vim.fn.setpos("'>", { 0, start_line + #vim.split(response, "\n") - 1, 2147483647, 0 })
    vim.cmd('normal! gv')
  end
end

-- Helper function to make API request with progress message
local function make_api_request_with_progress(context, instructions)
  local anthropic_key = os.getenv("ANTHROPIC_API_KEY")
  if not anthropic_key then
    vim.api.nvim_err_writeln("ANTHROPIC_API_KEY environment variable not set")
    return nil
  end

  local curl = require("plenary.curl")
  local json = vim.json
  local system_prompt = get_system_prompt()
  local user_prompt = context

  update_context_md(system_prompt, user_prompt)

  local request_body = json.encode({
    model = "claude-3-sonnet-20240229",
    system = get_system_prompt(),
    max_tokens = 4000,
    messages = {
      { role = "user", content = user_prompt }
    }
  })

  -- Show progress message
  vim.api.nvim_echo({ { "", "" } }, false, {})
  vim.api.nvim_echo({ { "Running ...", "WarningMsg" } }, true, {})

  -- Make API request in a separate thread
  vim.fn.jobstart({ "curl", "-X", "POST", "https://api.anthropic.com/v1/messages",
      "-H", "Content-Type: application/json",
      "-H", "X-API-Key: " .. anthropic_key,
      "-H", "anthropic-version: 2023-06-01",
      "-d", request_body,
      "--silent", "--show-error" },
    {
      on_stdout = function(_, data)
        if data and #data > 0 and data[1] ~= "" then
          local response_data = json.decode(table.concat(data))
          if response_data and response_data.content and response_data.content[1] and response_data.content[1].text then
            -- Clear progress message
            vim.api.nvim_echo({ { "", "" } }, false, {})
            -- Use the response
            use_api_response(response_data.content[1].text)
            vim.api.nvim_echo({ { "API request completed successfully.", "Normal" } }, true, {})
          end
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 and data[1] ~= "" then
          vim.api.nvim_err_writeln("API request failed: " .. table.concat(data))
        end
      end,
      on_exit = function(_, exit_code)
        if exit_code ~= 0 then
          vim.api.nvim_err_writeln("API request failed with exit code: " .. exit_code)
        end
        -- Clear progress message
        vim.api.nvim_echo({ { "", "" } }, false, {})
      end
    }
  )
end

-- Function to edit with instructions
local function edit_with_instructions(instructions)
  if not instructions or instructions == "" then
    return
  end

  local selected_text, start_line, end_line, before_text, after_text = get_selected_text()
  local file_name = vim.fn.expand("%:t")

  local context = string.format(
    "-----------------------------------\n" ..
    "You are editing the file: %s\n\n" ..
    "Here is the content of the file:\n" ..
    "```\n" ..
    "%s\n\n" ..
    "<<<SELECTION>>>\n\n" ..
    "%s\n\n" ..
    "<<<SELECTION>>>\n\n" ..
    "%s\n\n" ..
    "```\n" ..
    "Rewrite the code between the <<<SELECTION>>> markers based on the instructions.\n" ..
    "Instructions:\n%s\n\n" ..
    "Only output the rewritten code snipped without any additional formatting.\n" ..
    "If a change needs explanation, use a comment.\n" ..
    "Ensure the code is syntactically correct based on the file extension.\n" ..
    "Ensure the code follows the same style used everywhere else.\n" ..
    "Don't remove any features unless explicitly asked to do so.\n",
    file_name, before_text, selected_text, after_text, instructions
  )

  make_api_request_with_progress(context, instructions)
end

-- Function to generate code for instructions
local function generate_code_for_instructions(instructions)
  if not instructions or instructions == "" then
    return
  end

  local file_name = vim.fn.expand("%:t")
  local file_extension = vim.fn.fnamemodify(file_name, ":e")

  local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
  local before_text = table.concat(vim.api.nvim_buf_get_lines(0, 0, current_line_num - 1, false), "\n")
  local after_text = table.concat(vim.api.nvim_buf_get_lines(0, current_line_num, -1, false), "\n")

  local context = string.format(
    "You are editing the file: %s\n\n" ..
    "Here is the content of the file:\n" ..
    "```\n" ..
    "%s\n\n" ..
    "<<<CURSOR>>>\n\n" ..
    "%s\n\n" ..
    "```\n" ..
    "Generate code based on the following instructions:\n%s\n\n" ..
    "Only output the generated code snippet without any additional formatting.\n" ..
    "Ensure the code is syntactically correct for a %s file.\n" ..
    "Ensure the code follows the same style used everywhere else.\n" ..
    "Insert the generated code at the cursor position marked by <<<CURSOR>>>.\n",
    file_name, before_text, after_text, instructions, file_extension
  )

  make_api_request_with_progress(context, instructions)
end

-- Set up keymappings
local function setup_keymaps()
  vim.keymap.set('v', '<CR>', ':<C-u>EditWithInstructions<CR>', { noremap = true, silent = false })
  vim.keymap.set('i', '<C-CR>', '<Esc>:GenerateCode<CR>', { noremap = true })
  vim.keymap.set('n', '<CR>', ':GenerateCode<CR>', { noremap = true })
end

-- Setup function
function M.setup()
  -- Set up autocmd for updating LRU buffers
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      local current_buf = vim.api.nvim_get_current_buf()
      update_lru_buffers(current_buf)
    end,
  })

  -- Create user command for EditWithInstructions
  vim.api.nvim_create_user_command('EditWithInstructions', function(opts)
    vim.ui.input({
      prompt = "$ ",
    }, function(input)
      if input and input ~= "" then
        edit_with_instructions(input)
      end
    end)
  end, { nargs = '*', range = true })

  -- Create user command for GenerateCode
  vim.api.nvim_create_user_command('GenerateCode', function(opts)
    vim.ui.input({
      prompt = "$ ",
    }, generate_code_for_instructions)
  end, { nargs = '*' })

  setup_keymaps()
end

return M
