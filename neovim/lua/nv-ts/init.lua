require("nvim-treesitter.configs").setup {
  ensure_installed = { "bash", "c", "lua", "haskell", "rust", "html", "dockerfile",
                       "cpp", "diff", "cmake", "bibtex", "python"},
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
}
