" Dislaimer:
"
" This file is no longer an active part of my configuration and likely has
" unresolved issues.
"
" I've transitioned my config to neovim's lua configuration (see neovim folder)
" This file remains as a maybe working vimscript config for use in a pinch.

" General ----------------------------------------------------------------------
    set nocompatible
    set guifont=Inconsolata-g\ for\ Powerline
    set undolevels=50
    set cursorline
    set hlsearch
    set timeout
    set ttimeoutlen=100
    set path+=**

    set wildmenu
    set wildmode=longest:list,full

    syntax enable
    filetype plugin indent on

    " Colors
    let g:airline_powerline_fonts = 1
    let g:airline_theme='one'
    set background=dark
    "colorscheme one

    set laststatus=2

    set mouse=a

" Formatting Rules -------------------------------------------------------------
    set tabstop=2
    set shiftwidth=2
    set softtabstop=2
    set expandtab
    set autoindent
    set relativenumber
    set number
    set backspace=indent,eol,start

" Plugins ----------------------------------------------------------------------
    call plug#begin('~/.vim/plugged')

    Plug 'neovim/nvim-lspconfig'
    Plug 'vim-airline/vim-airline'
    Plug 'bling/vim-bufferline'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'

    " Haskell Plugins
    "Plug 'alx741/vim-hindent', {'for': 'haskell'}

    " Colors
    Plug 'rakr/vim-one'
    call plug#end()

" LSP config  ---------------------------------------------------------------
  " See `:help vim.lsp.*` for documentation on any of the below functions
  nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <space> D'<cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <space>rn <cmd>lua vim.lsp.buf.rename()<CR>
  nnoremap <space>ca <cmd>lua vim.lsp.buf.code_action()<CR>
  nnoremap <space>e <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
  nnoremap [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
  nnoremap ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
  nnoremap <space>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
  nnoremap <space>f <cmd>lua vim.lsp.buf.formatting()<CR>

  " Auto Format
  autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

  " LSPs
  lua require'lspconfig'.bashls.setup{}

" Bufferline ---------------------------------------------------------------
    " Don't echo it to the command line, it's in the airline bar anyways
    let g:bufferline_echo = 0

" Completion ---------------------------------------------------------------
    set omnifunc=syntaxcomplete#Complete

    " Close preview after completion
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
" Makeprg =-----------------------------------------------------------------
    autocmd Filetype tex setlocal makeprg=pdflatex\ %

" General Custom Key Bindings ----------------------------------------------

    " Easy Window nagivation
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l
    nnoremap <C-h> <C-w>h

    " Terminal Mode Bindings
    tnoremap <Esc> <C-\><C-n><CR>
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap <C-h> <C-\><C-n><C-w>h

    " Easier buffer navigation
    nnoremap gb :bnext<CR>
    nnoremap gB :bprevious<CR>

    " Center search terms
    nnoremap n nzz
    nnoremap N Nzz
    nnoremap * *zz
    nnoremap # #zz

    " Align
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
