OPTS = { noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<SPACE>', '<NOP>', OPTS)
vim.g.mapleader = ' '

-- no hl
vim.api.nvim_set_keymap('n', '<Leader>h', ':set hlsearch!<CR>', OPTS)

-- Explorer
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', OPTS)

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<cr>', OPTS)
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<cr>', OPTS)
vim.api.nvim_set_keymap('n', '<Leader>fb', ':Telescope buffers<cr>', OPTS)
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<cr>', OPTS)

-- LSP
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', OPTS)
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', OPTS)
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', OPTS)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', OPTS)
vim.api.nvim_set_keymap('n', '<Leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', OPTS)


-- Better window movement
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { silent = true})

-- Better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', OPTS)
vim.api.nvim_set_keymap('v', '>', '>gv', OPTS)

-- Better escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', OPTS)

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', OPTS)
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', OPTS)

