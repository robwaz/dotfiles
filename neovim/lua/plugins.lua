local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Package Manager
  use 'wbthomason/packer.nvim'

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use { "L3MON4D3/LuaSnip",tag = "v2.*", run = "make install_jsregexp" }
  use 'saadparwaiz1/cmp_luasnip'
  use 'onsails/lspkind.nvim'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Git
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use "tpope/vim-fugitive"

  -- AI
  use {"github/copilot.vim"}

  -- Functional
  use {'nvim-telescope/telescope.nvim', tag = '0.1.4', requires = 'nvim-lua/plenary.nvim'}
  use {'nvim-tree/nvim-tree.lua',requires = {'nvim-tree/nvim-web-devicons'}}
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use {'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Misc
  use {'ThePrimeagen/vim-be-good'}

  -- Colorschemes
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'folke/tokyonight.nvim'

  if Packer_bootstrap then
    require('packer').sync()
  end
end)
