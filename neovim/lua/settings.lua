--vim.o.iskeyword="+=-"
-- vim.o.formatoptions="-=cro"
vim.o.undolevels=50                 -- Much undo
vim.o.hidden=true                   -- Allow for multiple editable buffers
vim.o.cursorline=true               -- Makes it easier to know which line is current
vim.o.hlsearch=true                 -- Makes it easier to know which line is current
-- vim.o.t_Co="256"
vim.o.ttimeoutlen=100               -- Makes it easier to know which line is current
vim.o.background="dark"             -- Makes it easier to know which line is current
vim.o.mouse='a'                     -- Enable mouse support
vim.o.smartindent=true              -- "smart" indenting
vim.o.autoindent=true               -- Auto indenting
vim.o.expandtab=true                -- Expand tabs to settings # of spaces ?
vim.o.termguicolors=true

vim.o.tabstop=2                     -- Tab = 2 spaces
vim.o.shiftwidth=2                  -- Change the number of space characters inserted for indentation
vim.o.softtabstop=2                 -- Makes it easier to know which line is current

vim.o.signcolumn="yes"              -- Always show left side gutter so text doesn't shift
vim.o.relativenumber=true           -- Show jump distance 
vim.o.number=true                   -- Show current line #
vim.o.backspace="indent,eol,start"  -- ???
vim.o.syntax="true"                 -- Makes it easier to know which line is current

-- Configure make command
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'tex',
  command = 'setlocal makeprg=pdflatex\\ %'
})
