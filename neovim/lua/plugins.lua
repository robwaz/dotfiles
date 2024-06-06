local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Package Manager
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'


  use {'nvim-telescope/telescope.nvim', tag = '0.1.4', requires = 'nvim-lua/plenary.nvim'}
  -- ??? Unsorted
  use 'hrsh7th/nvim-cmp'
  use 'windwp/nvim-autopairs'
  use 'tikhomirov/vim-glsl'
  use {'nvim-tree/nvim-tree.lua',requires = {'nvim-tree/nvim-web-devicons'}}
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use {'ThePrimeagen/vim-be-good'}
  use {'nvim-lualine/lualine.nvim', requires = { 'nvim-tree/nvim-web-devicons', opt = true }}

  -- Colorschemes
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'folke/tokyonight.nvim'

  if Packer_bootstrap then
    require('packer').sync()
  end
end)
