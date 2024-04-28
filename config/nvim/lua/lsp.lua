require("mason").setup()
require("mason-lspconfig").setup()

local lsp_formatting = function(bufnr)
  if not vim.g.disable_formatting then
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "tsserver" and client.name ~= "denols"
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

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.code_actions.eslint.with({
      extra_args = {},
    }),
    require("null-ls").builtins.diagnostics.eslint.with({
      extra_args = {},
    }),
    require("null-ls").builtins.formatting.prettierd
  }
})

local lsp = require("lspconfig");
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lsp.rust_analyzer.setup { on_attach = on_attach, capabilities = capabilities }

lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  format = {
    enable = true,
    -- Put format options here
    -- NOTE: the value should be STRING!!
    defaultConfig = {
      indent_style = "space",
      indent_size = "2",
    }
  },

  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }

      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    }
  },


}

lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = function(fname)
    return lsp.util.root_pattern(".git")(fname) or lsp.util.root_pattern("package.json")(fname)
  end
}

lsp.elixirls.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

lsp.denols.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
}

-- lsp.eslint_d.setup {
--   capabilities = capabilities,
--   on_attach = on_attach
-- }

lsp.emmet_ls.setup({
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
  init_options = {
    html = {
      options = {
        ["bem.enabled"] = true,
      },
    },
  }
})
