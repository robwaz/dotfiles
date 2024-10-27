require"lspconfig".asm_lsp.setup{
  filetypes = {
   "asm"
 }
}
require"lspconfig".autotools_ls.setup{}
require"lspconfig".bashls.setup{}
require('lspconfig').clangd.setup{
  filetypes = {
    "c",
    "cpp"
  }
}
require"lspconfig".cmake.setup{}
require"lspconfig".docker_compose_language_service.setup{}
require"lspconfig".dockerls.setup{}
require('lspconfig').hls.setup{
  filetypes = {
    "haskell"
  }
}
require"lspconfig".jsonls.setup{}
require"lspconfig".ltex.setup{}
require"lspconfig".lua_ls.setup{}
require"lspconfig".markdown_oxide.setup{}
require"lspconfig".pyright.setup{
  filetypes = {
    "python"
  }
}

require'lspconfig'.rust_analyzer.setup({
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

require"lspconfig".sqls.setup{}
require"lspconfig".taplo.setup{}
require"lspconfig".yamlls.setup{}
