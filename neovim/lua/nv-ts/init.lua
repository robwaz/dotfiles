require'nvim-treesitter'.install { "bash", "c", "lua", "haskell", "rust",
  "html", "dockerfile", "cpp", "diff", "cmake", "bibtex", "python", "elixir"}

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})
