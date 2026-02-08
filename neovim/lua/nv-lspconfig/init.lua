local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.config("asm_lsp", {
  filetypes = {"asm"},
  capabilities = capabilities
})

vim.lsp.config("autotools_ls", {
  capabilities = capabilities
})

vim.lsp.config("bashls", {
  capabilities = capabilities
})
vim.lsp.config("clangd", {
  filetypes = {"c","cpp"},
  capabilities = capabilities
})
vim.lsp.config("cmake", {
  capabilities = capabilities
})
vim.lsp.config("docker_compose_language_service", {
  capabilities = capabilities
})
vim.lsp.config("dockerls", {
  capabilities = capabilities
})
vim.lsp.config("expert", {
  filetypes = {"elixir", "eelixir", "heex"},
  root_markers= {"mix.exs", ".git"},
  capabilities = capabilities
})
vim.lsp.config("hls", {
  filetypes = {"haskell"},
  capabilities = capabilities
})
vim.lsp.config("jsonls", {
  capabilities = capabilities
})
vim.lsp.config("ltex", {
  capabilities = capabilities
})
vim.lsp.config("lua_ls", {
  capabilities = capabilities
})
vim.lsp.config("markdown_oxide", {
  capabilities = capabilities
})
vim.lsp.config("pyright", {
  filetypes = {"python"},
  capabilities = capabilities
})

vim.lsp.config("rust_analyzer", {
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

vim.lsp.config("sqls", {
  capabilities = capabilities
})
vim.lsp.config("taplo", {
  capabilities = capabilities
})
vim.lsp.config("yamlls", {
  capabilities = capabilities
})
