require("lspconfig").setup()

-- LSPs requiring configuration have their own config
-- but are listed here by comment
require("lspconfig").asm_lsp.setup()
require("lspconfig").autotools_ls.setup()
require("lspconfig").bashls.setup()
-- clangd
require("lspconfig").cmake.setup()
require("lspconfig").docker_compose_language_service.setup()
require("lspconfig").dockerls.setup()
-- hls
require("lspconfig").jsonls.setup()
require("lspconfig").ltex.setup()
require("lspconfig").lua_ls.setup()
require("lspconfig").markdown_oxide.setup()
require("lspconfig").pyright.setup()
-- rust_analyzer
require("lspconfig").sqls.setup()
require("lspconfig").taplo.setup()
require("lspconfig").yamlls.setup()
