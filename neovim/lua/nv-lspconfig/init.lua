local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require"lspconfig".asm_lsp.setup{
  filetypes = {
   "asm"
  },
  capabilities = capabilities
}
require"lspconfig".autotools_ls.setup{
  capabilities = capabilities
}
require"lspconfig".bashls.setup{
  capabilities = capabilities
}
require('lspconfig').clangd.setup{
  filetypes = {
    "c",
    "cpp"
  },
  capabilities = capabilities
}
require"lspconfig".cmake.setup{
  capabilities = capabilities
}
require"lspconfig".docker_compose_language_service.setup{
  capabilities = capabilities
}
require"lspconfig".dockerls.setup{
  capabilities = capabilities
}
require('lspconfig').hls.setup{
  filetypes = {
    "haskell"
  },
  capabilities = capabilities
}
require"lspconfig".jsonls.setup{
  capabilities = capabilities
}
require"lspconfig".ltex.setup{
  capabilities = capabilities
}
require"lspconfig".lua_ls.setup{
  capabilities = capabilities
}
require"lspconfig".markdown_oxide.setup{
  capabilities = capabilities
}
require"lspconfig".pyright.setup{
  filetypes = {
    "python"
  },
  capabilities = capabilities
}

require'lspconfig'.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach=on_attach,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  }
})

require"lspconfig".sqls.setup{
  capabilities = capabilities
}
require"lspconfig".taplo.setup{
  capabilities = capabilities
}
require"lspconfig".yamlls.setup{
  capabilities = capabilities
}
