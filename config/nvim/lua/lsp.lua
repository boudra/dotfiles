require("mason").setup()

require("mason-lspconfig").setup {
  ensure_installed = { "ts_ls", "rust_analyzer", "elixirls", "emmet_ls" },
}


local lsp_formatting = function(bufnr)
  if not vim.g.disable_formatting then
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "ts_ls" and client.name ~= "denols"
      end,
      bufnr = bufnr,
    })
  end
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<Leader>h', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>")

  if client.supports_method("textDocument/formatting") then
    vim.keymap.set('v', '<Leader>r', vim.lsp.buf.format, bufopts)

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    require("none-ls.code_actions.eslint"),
    require("none-ls.diagnostics.eslint"),
    null_ls.builtins.formatting.prettierd
  }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local util = require("lspconfig.util")

-- Configure LSP servers using the new vim.lsp.config API
vim.lsp.config('rust_analyzer', {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = util.root_pattern("Cargo.toml", "rust-project.json")
})
vim.lsp.enable('rust_analyzer')

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = util.root_pattern(".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git"),
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    }
  },
})
vim.lsp.enable('lua_ls')

vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function(fname)
    return util.root_pattern(".git")(fname) or util.root_pattern("package.json")(fname)
  end
})
vim.lsp.enable('ts_ls')

vim.lsp.config('elixirls', {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "elixir-ls" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_dir = util.root_pattern("mix.exs", ".git")
})
vim.lsp.enable('elixirls')

vim.lsp.config('tailwindcss', {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte" },
  root_dir = util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.mjs", "tailwind.config.ts", "postcss.config.js", "postcss.config.cjs", "postcss.config.mjs", "postcss.config.ts", "package.json", "node_modules", ".git")
})
vim.lsp.enable('tailwindcss')

vim.lsp.config('denols', {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "deno", "lsp" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
})
vim.lsp.enable('denols')

vim.lsp.config('emmet_ls', {
  -- on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "emmet-ls", "--stdio" },
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  }
})
vim.lsp.enable('emmet_ls')
