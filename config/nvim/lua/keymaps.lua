vim.g.mapleader = " "
vim.g.maplocalleader = " "

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end


vim.keymap.set("n", "<Leader>q", "<cmd>x<cr>")
vim.keymap.set("n", "<Leader>qq", "<cmd>qa!<cr>")
vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<Leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<Leader>g", "<cmd>Telescope live_grep<cr>")

local tb = require('telescope.builtin')

vim.keymap.set("v", "<Leader>g", function()
  local text = vim.getVisualSelection()
  tb.live_grep({ default_text = text })
end)

vim.keymap.set("n", "<M-k>", function()
  local text = vim.getVisualSelection()
  tb.commands()
end)

vim.keymap.set("n", "<Leader>b", "<cmd>NvimTreeFindFileToggle<cr>")
vim.keymap.set("n", "<Leader>d", function()
  vim.diagnostic.open_float(nil, {focus=false})
end)

vim.keymap.set("n", "gs", "<cmd>Git<cr>")
vim.keymap.set("n", "gv", "<cmd>GBrowse<cr>")
vim.keymap.set("v", "gv", "<cmd>'<,'>GBrowse<cr>")
vim.keymap.set("n", "gb", "<cmd>Git blame<cr>")

vim.keymap.set("n", "/", "<Plug>(easymotion-sn)")
vim.keymap.set("n", "n", "<Plug>(easymotion-next)")
vim.keymap.set("n", "N", "<Plug>(easymotion-prev)")

vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "gp", "<cmd>GitPush<cr>")

vim.api.nvim_create_user_command(
    'GitPush',
    function(opts)
        local cwd = vim.fn.getcwd()
        print(cwd)
        vim.fn.jobstart({
          "tmux",
          "popup",
          string.format("cd '%s' && git push -u origin HEAD", cwd)
        }, { detach = true })
    end,
    {}
)

vim.api.nvim_create_user_command("GitBlame", "Git blame", {});
vim.api.nvim_create_user_command("Gbrowse", "GBrowse", {});
vim.api.nvim_create_user_command("GitBrowse", "GBrowse", {});

vim.api.nvim_create_user_command("GitAddFile", "Git add %", {});
vim.api.nvim_create_user_command("GitResetFile", "Git reset %", {});
vim.api.nvim_create_user_command("LspRestartAll", "LspRestart", {});

vim.api.nvim_create_user_command(
    'GitPull',
    function(opts)
        local cwd = vim.fn.getcwd()
        print(cwd)
        vim.fn.jobstart({
          "tmux",
          "popup",
          string.format("cd '%s' && git pull", cwd)
        }, { detach = true })
    end,
    {}
)

vim.api.nvim_create_user_command(
    'GitDiffProject',
    function(opts)
      local cwd = vim.fn.getcwd()
      print(cwd)
      vim.fn.jobstart({
        "tmux",
        "popup",
        "-h", "80%",
        "-w", "80%",
        "-E",
        string.format("cd '%s' && git diff", cwd)
      }, { detach = true })
    end,
    {}
)

vim.keymap.set("n", "<Leader>t", function()
  local cwd = vim.fn.getcwd()
  print(cwd)
  vim.fn.jobstart({
    "tmux",
    "popup",
    "-h", "80%",
    "-w", "80%",
    "-E",
    string.format("cd '%s' && $SHELL", cwd)
  }, { detach = true })
end)

vim.g["easymotion_smartcase"] = 1
vim.g["easymotion_use_smartsign_us"] = 1

vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("v", "<M-c>", '"+y')
vim.keymap.set("v", "<D-c>", '"+y')

vim.keymap.set("n", "<M-s>", '<cmd>w<cr>')
