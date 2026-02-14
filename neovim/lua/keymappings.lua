OPTS = { noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<SPACE>', '<NOP>', OPTS)
vim.g.mapleader = ' '

-- no hl
vim.keymap.set('n', '<Leader>h', ':set hlsearch!<CR>', OPTS)

-- Explorer
vim.keymap.set('n', '<Leader>e', ':NvimTreeToggle<CR>', OPTS)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<cr>', OPTS)
vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<cr>', OPTS)
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<cr>', OPTS)
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>', OPTS)
vim.keymap.set('n', '<leader>fw', function()
  local word = vim.fn.expand("<cword>")
  builtin.grep_string({search = word})
end)
vim.keymap.set('n', '<leader>fW', function()
  local word = vim.fn.expand("<cWORD>")
  builtin.grep_string({search = word})
end)

-- LSP
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', OPTS)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', OPTS)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', OPTS)
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', OPTS)
vim.keymap.set('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', OPTS)
vim.keymap.set('n', '<Leader>d', vim.diagnostic.open_float, { desc = "Show diagnostics" })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = "Diagnostics to LocList" })

-- Quickfix 
vim.keymap.set('n', ']q', '<cmd>cnext<cr>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprev<cr>', { desc = 'Previous quickfix item' })
vim.keymap.set('n', '<leader>co', '<cmd>copen<cr>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<cr>', { desc = 'Close quickfix list' })
vim.keymap.set('n', ']Q', '<cmd>clast<cr>', { desc = 'Last quickfix item' })
vim.keymap.set('n', '[Q', '<cmd>cfirst<cr>', { desc = 'First quickfix item' })

vim.keymap.set('n', '<leader>cd', vim.diagnostic.setqflist, { desc = "Diagnostics to QFL" })
vim.keymap.set('n', '<leader>cs', vim.lsp.buf.document_symbol, { desc = "Symbols to QFL" })

-- Better window movement
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true})
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true})
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true})
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true})

-- Better indenting
vim.keymap.set('v', '<', '<gv', OPTS)
vim.keymap.set('v', '>', '>gv', OPTS)

-- Better escape
vim.keymap.set('i', 'jk', '<ESC>', OPTS)

-- Tab switch buffer
vim.keymap.set('n', '<TAB>', ':bnext<CR>', OPTS)
vim.keymap.set('n', '<S-TAB>', ':bprevious<CR>', OPTS)

