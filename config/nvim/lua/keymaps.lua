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
vim.keymap.set("n", "<Leader>qq", "<cmd>xa<cr>")
vim.keymap.set("n", "<Leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<Leader>f", "<cmd>:lua ProjectFiles()<cr>")
vim.keymap.set("n", "<Leader>g", "<cmd>Telescope live_grep<cr>")

local tb = require('telescope.builtin')

vim.keymap.set("v", "<Leader>g", function()
  local text = vim.getVisualSelection()
  tb.live_grep({ default_text = text })
end)

vim.keymap.set("n", "<Leader>b", "<cmd>NvimTreeToggle<cr>")
vim.keymap.set("n", "<Leader>d", "<cmd>TroubleToggle<cr>")

vim.keymap.set("n", "gs", "<cmd>Git<cr>")
vim.keymap.set("n", "gv", "<cmd>GBrowse<cr>")
vim.keymap.set("v", "gv", "<cmd>'<,'>GBrowse<cr>")
vim.keymap.set("n", "gb", "<cmd>Git blame<cr>")

vim.keymap.set("n", "/", "<Plug>(easymotion-sn)")
vim.keymap.set("n", "n", "<Plug>(easymotion-next)")
vim.keymap.set("n", "N", "<Plug>(easymotion-prev)")

vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "gp", function()
  local cwd = vim.fn.getcwd()
  print(cwd)
  vim.fn.jobstart({
    "tmux",
    "popup",
    string.format("cd '%s' && git push -u origin HEAD", cwd)
  }, { detach = true })
end)

vim.g["easymotion_smartcase"] = 1
vim.g["easymotion_use_smartsign_us"] = 1

vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("v", "<M-c>", '"+y')
vim.keymap.set("v", "<D-c>", '"+y')

vim.keymap.set("n", "<M-s>", '<cmd>w<cr>')
