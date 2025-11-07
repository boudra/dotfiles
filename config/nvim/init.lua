require("options")
require("plugins")
require("completion")
require("lsp")
require("keymaps")

vim.cmd("colorscheme catppuccin")

require("mason-lspconfig").setup {
  ensure_installed = { "ts_ls", "rust_analyzer" },
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "elixir",
    "heex",
    "css",
    "html", "javascript", "typescript", "go", "dockerfile", "rust", "vim", "lua", "solidity",
    "tsx"
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local telescope = require('telescope')

telescope.load_extension('fzf')

telescope.setup { defaults = {
  vimgrep_arguments = {
    "rg",
    "-L",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--hidden",
    "--trim",
    "--glob",
    "!**/.git/*"
  },
  mappings = {
    i = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<esc>"] = "close"
    }
  }
},
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '-L', '--hidden', '--glob', '!**/.git/*' },
    },
  },
}


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
  },
  view = {
    adaptive_size = true,
    -- mappings = {
    --   list = {
    --     { key = "u", action = "dir_up" },
    --   },
    -- },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.g["lightline"] = {
  colorscheme = 'catppuccin',
  active = {
    left = {
      { 'mode',      'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' }
    },
  },
  component_function = {
    gitbranch = 'FugitiveHead',
  },
}

vim.g["easymotion_smartcase"] = 1
vim.g["easymotion_use_smartsign_us"] = 1

vim.api.nvim_create_user_command(
  'Commit',
  function(args)
    vim.api.nvim_out_write("Running Git commit and push...\n")

    local git_cmd = 'git commit -a -m "' .. args.args .. '" && git push -u origin HEAD'
    local result = vim.fn.system(git_cmd)
    local exit_code = vim.v.shell_error

    if exit_code == 0 then
      vim.api.nvim_out_write("Git commit and push successful!\n")
    else
      vim.api.nvim_err_writeln("Git command failed: " .. result)
    end
  end,
  { nargs = 1 }
)

-- require('avante_lib').load()
--
-- require('avante').setup({
--   provider = "claude", -- Recommend using Claude
-- });
--

-- local lru_buffers = {}
--
-- -- Function to update LRU buffer list
-- local function update_lru_buffers(buf)
--   -- Check if the buffer is a file buffer
--   if vim.api.nvim_buf_get_option(buf, 'buftype') == '' and vim.fn.bufname(buf) ~= '' then
--     -- Remove the buffer if it's already in the list
--     for i, v in ipairs(lru_buffers) do
--       if v == buf then
--         table.remove(lru_buffers, i)
--         break
--       end
--     end
--     -- Add the buffer to the front of the list
--     table.insert(lru_buffers, 1, buf)
--     -- Keep only the 3 least recently used file buffers
--     while #lru_buffers > 3 do
--       table.remove(lru_buffers)
--     end
--   end
-- end
--
-- -- Update LRU buffers whenever a buffer is entered
-- vim.api.nvim_create_autocmd("BufEnter", {
--   callback = function()
--     local current_buf = vim.api.nvim_get_current_buf()
--     update_lru_buffers(current_buf)
--   end,
-- })
--
-- vim.api.nvim_create_user_command('EditWithInstructions', function(opts)
--   local function edit_with_instructions(instructions)
--     if not instructions or instructions == "" then
--       return
--     end
--
--     local anthropic_key = os.getenv("ANTHROPIC_API_KEY")
--     if not anthropic_key then
--       vim.api.nvim_err_writeln("ANTHROPIC_API_KEY environment variable not set")
--       return
--     end
--
--     local curl = require("plenary.curl")
--     local json = vim.json
--
--     local start_line, end_line
--     if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' or vim.fn.mode() == '\22' then
--       start_line = vim.fn.line("'<")
--       end_line = vim.fn.line("'>")
--     else
--       start_line = vim.fn.line(".")
--       end_line = start_line
--     end
--
--     local selected_text = table.concat(vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false), '\n')
--
--     local file_name = vim.fn.expand("%:t")
--
--     local before_text = table.concat(vim.api.nvim_buf_get_lines(0, 0, start_line - 1, false), '\n')
--     local after_text = table.concat(vim.api.nvim_buf_get_lines(0, end_line, -1, false), '\n')
--
--     local project_context = ""
--
--     if #lru_buffers > 1 then
--       project_context = "Here are some relevant files in the project:\n\n"
--       -- Get content of LRU buffers, skipping the first one
--       for i = 2, #lru_buffers do
--         local buf = lru_buffers[i]
--         local buf_name = vim.api.nvim_buf_get_name(buf)
--         if vim.api.nvim_buf_is_valid(buf) then
--           local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
--           project_context = project_context .. "File: " .. buf_name .. "\n"
--           project_context = project_context .. table.concat(lines, "\n") .. "\n------------------------------------\n"
--         end
--       end
--     end
--
--     local system_prompt = "You are a helpful software engineer assistant.\n\n"
--         .. "- Don't elide any code from your output.\n"
--         .. "- Pay close attention to the context and where the code is placed.\n"
--         .. "- When you are asked to operate on code, your message should contain only code, no other text or markdown.\n"
--         .. "- Never wrap the code in backticks, just reply with the code.\n\n"
--         .. project_context
--
--     local context = string.format(
--       "-----------------------------------\n" ..
--       "Filename: %s\n\n" ..
--       "%s\n\n" ..
--       marker .. "\n\n" ..
--       "%s\n\n" ..
--       marker .. "\n\n" ..
--       "%s\n\n" ..
--       "Edit instructions:\n%s\n\n" ..
--       "Rewrite the code between the " .. marker .. " markers based on the instructions.\n" ..
--       "Only output the rewritten code snipped without any additional formatting.\n" ..
--       "If a change needs explanation, use a comment.\n" ..
--       "Ensure the code is syntactically correct based on the file extension.\n" ..
--       "Ensure the code follows the same style used everywhere else.\n" ..
--       "Don't remove any features unless explicitly asked to do so.\n",
--       file_name, before_text, selected_text, after_text, instructions
--     )
--
--     local request_body = json.encode({
--       model = "claude-3-sonnet-20240229",
--       system = system_prompt,
--       max_tokens = 4000,
--       messages = {
--         { role = "user", content = context }
--       }
--     })
--
--     local response = curl.post("https://api.anthropic.com/v1/messages", {
--       headers = {
--         ["Content-Type"] = "application/json",
--         ["X-API-Key"] = anthropic_key,
--         ["anthropic-version"] = "2023-06-01"
--       },
--       body = request_body,
--       timeout = 60 * 1000
--     })
--
--     if response.status ~= 200 then
--       vim.api.nvim_err_writeln("API request failed with code " .. response.status .. response.body)
--       return
--     end
--
--     local response_data = json.decode(response.body)
--     local ai_response = response_data.content[1].text
--
--     vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, vim.split(ai_response, "\n"))
--     vim.fn.setpos("'<", { 0, start_line, 1, 0 })
--     vim.fn.setpos("'>", { 0, start_line + #vim.split(ai_response, "\n") - 1, 2147483647, 0 })
--     vim.cmd('normal! gv')
--   end
--
--   vim.ui.input({
--     prompt = "$ ",
--   }, edit_with_instructions)
-- end, { nargs = '*', range = true })
--
-- vim.keymap.set('v', '<CR>', ':EditWithInstructions<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<CR>', ':EditWithInstructions ', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-CR>', '<Esc>:EditWithInstructions ', { noremap = true })
-- vim.keymap.set('n', '<CR>', ':EditWithInstructions<CR>', { noremap = true, silent = true })
--
-- local function generate_code_for_instructions(instructions)
--   if not instructions or instructions == "" then
--     return
--   end
--
--   local anthropic_key = os.getenv("ANTHROPIC_API_KEY")
--   if not anthropic_key then
--     vim.api.nvim_err_writeln("ANTHROPIC_API_KEY environment variable not set")
--     return
--   end
--
--   local curl = require("plenary.curl")
--   local json = vim.json
--
--   local system_prompt = "You are a helpful software engineer assistant.\n\n"
--       .. "- Don't elide any code from your output.\n"
--       .. "- Pay close attention to the context and where the code is placed.\n"
--       .. "- When you are asked to operate on code, your message should contain only code, no other text or markdown.\n"
--       .. "- Never wrap the code in backticks, just reply with the code.\n\n"
--
--   local context = string.format(
--     "Filename: %s\n\n" ..
--     "Generate code based on the following instructions:\n%s\n\n" ..
--     "Only output the generated code snipped without any additional formatting.\n" ..
--     "Ensure the code is syntactically correct based on the file extension.\n" ..
--     "Ensure the code follows the same style used everywhere else.\n",
--     vim.fn.expand("%:t"), instructions
--   )
--
--   local request_body = json.encode({
--     model = "claude-3-sonnet-20240229",
--     system = system_prompt,
--     max_tokens = 4000,
--     messages = {
--       { role = "user", content = context }
--     }
--   })
--
--   local response = curl.post("https://api.anthropic.com/v1/messages", {
--     headers = {
--       ["Content-Type"] = "application/json",
--       ["X-API-Key"] = anthropic_key,
--       ["anthropic-version"] = "2023-06-01"
--     },
--     body = request_body,
--     timeout = 60 * 1000
--   })
--
--   if response.status ~= 200 then
--     vim.api.nvim_err_writeln("API request failed with code " .. response.status .. response.body)
--     return
--   end
--
--   local response_data = json.decode(response.body)
--   local ai_response = response_data.content[1].text
--
--   vim.api.nvim_put(vim.split(ai_response, "\n"), "c", true, true)
-- end
--
-- vim.api.nvim_set_keymap('i', '<C-CR>', '<Esc>:call generate_code_for_instructions(input("$ "))<CR>', { noremap = true })
--
-- -- require("gp").setup({
-- --   command_prompt_prefix_template = "> ",
-- --   hooks = {
-- --     Rewrite = function(gp, params)
-- --       local start_pos = vim.fn.getpos("'<")[2]
-- --       local end_pos = vim.fn.getpos("'>")[2]
-- --       local before_start_pos = math.max(1, start_pos - 1000)
-- --       local after_end_pos = end_pos + 1000
-- --
-- --       local before_text = vim.fn.getline(before_start_pos, start_pos - 1)
-- --       local after_text = vim.fn.getline(end_pos + 1, after_end_pos)
-- --
-- --       before_text = table.concat(before_text, "\n")
-- --       after_text = table.concat(after_text, "\n")
-- --
-- --       local template = "In this file: {{filename}} which is of type: {{filetype}}\n" ..
-- --           "I want you to rewrite a snippet of code.\n" ..
-- --           "The code immediately before it is:\n" ..
-- --           before_text .. "\n" ..
-- --           "The chunk of code to be rewritten is:\n" ..
-- --           "{{selection}}" .. "\n" ..
-- --           "The code immediately after is:\n" ..
-- --           after_text .. "\n" ..
-- --           "Only rewrite the snippet and ONLY output the code that should replace it, don't output anything else.\n" ..
-- --           "DO NOT reply anything else, ONLY the code that should replace the selection.\n" ..
-- --           "The instructions to rewrite are: {{command}}"
-- --
-- --
-- --       local agent = gp.get_command_agent()
-- --
-- --       gp.Prompt(
-- --         params,
-- --         gp.Target.rewrite,
-- --         agent,
-- --         template,
-- --         "Rewrite > "
-- --       )
-- --     end,
-- --     Append = function(gp, params)
-- --       local start_pos, end_pos
-- --       if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' or vim.fn.mode() == '' then
-- --         start_pos = vim.fn.getpos("'<")[2]
-- --         end_pos = vim.fn.getpos("'>")[2]
-- --       else
-- --         start_pos = vim.fn.line('.')
-- --         end_pos = start_pos
-- --       end
-- --
-- --       local before_start_pos = math.max(1, start_pos - 1000)
-- --       local after_end_pos = end_pos + 1000
-- --
-- --       local before_text = vim.fn.getline(before_start_pos, start_pos - 1)
-- --       local after_text = vim.fn.getline(end_pos + 1, after_end_pos)
-- --
-- --       before_text = table.concat(before_text, "\n")
-- --       after_text = table.concat(after_text, "\n")
-- --
-- --       local template = "In this file: {{filename}} which is of type: {{filetype}}\n" ..
-- --           "I want you to write code where it's marked as $$ADD_CODE_HERE$$:\n" ..
-- --           before_text ..
-- --           "{{selection}}" .. "$$ADD_CODE_HERE$$\n" ..
-- --           after_text .. "\n" ..
-- --           "ONLY output the code that should replace the marker, don't output anything else.\n" ..
-- --           "The instructions to write the code are: {{command}}\n"
-- --
-- --       local agent = gp.get_command_agent()
-- --
-- --       gp.Prompt(
-- --         params,
-- --         gp.Target.append,
-- --         agent,
-- --         template,
-- --         "Append > "
-- --       )
-- --     end,
-- --   },
-- --   providers = {
-- --     anthropic = {
-- --       disable = false,
-- --     }
-- --   },
-- --   agents = {
-- --     {
-- --       name = "ChatGPT4o",
-- --       disable = true,
-- --     },
-- --     {
-- --       name = "CodeGPT4o",
-- --       disable = true,
-- --     },
-- --     {
-- --       name = "ChatGPT3-5",
-- --       disable = true,
-- --     },
-- --     {
-- --       name = "CodeGPT3-5",
-- --       disable = true,
-- --     },
-- --     {
-- --       name = "ChatCopilot",
-- --       disable = true,
-- --     },
-- --     {
-- --       name = "ChatClaude-3-5-Sonnet",
-- --       disable = true
-- --     },
-- --     {
-- --       name = "ChatClaude-3-Haiku",
-- --       disable = true
-- --     },
-- --     {
-- --       name = "CodeClaude-3-5-Sonnet",
-- --       disable = true,
-- --     },
-- --     {
-- --       name = "CodeClaude-3-Haiku",
-- --       disable = true,
-- --     }, {
-- --     provider = "anthropic",
-- --     name = "Claude-3-5-Sonnet",
-- --     chat = true,
-- --     command = true,
-- --     model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
-- --     system_prompt = "You are a helpful software engineer assistant.\n\n"
-- --         .. "- If you're unsure don't guess and say you don't know instead.\n"
-- --         .. "- Ask a question if you need clarification to provide better answer.\n"
-- --         .. "- Don't elide any code from your output.\n"
-- --         .. "- Pay close attention to the context and where the code is placed.\n"
-- --         .. "- When you are asked to operate on code, your message should contain only code, no other text or markdown.\n"
-- --         .. "- Never wrap the code in backticks, just reply with the code.",
-- --   },
-- --   }
-- -- })
--

-- local llm = require("llm")
--
-- llm.setup()
