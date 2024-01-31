-- Set the leader key to space
vim.g.mapleader = ' '

-- Set tabs to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Use block cursor in insert mode
vim.o.guicursor = ""

-- Return from file explorer to last open buffer ([b]ack to [b]uffer)
vim.keymap.set('n', '<leader>bb', function()
	vim.cmd([[b#]])
end)

-- Recenter page when jumping up and down
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Move between windows more easily
vim.keymap.set('n', '<C-h>', '<C-w>h');
vim.keymap.set('n', '<C-j>', '<C-w>j');
vim.keymap.set('n', '<C-k>', '<C-w>k');
vim.keymap.set('n', '<C-l>', '<C-w>l');

-- Set relative line numbers by default
vim.cmd([[set number]])
vim.cmd([[set relativenumber]])

-- Toggle between relative and absolute numbers
vim.keymap.set('n', '<leader>n', function()
	vim.cmd([[set invrelativenumber]])	
end)

-- Open the [c]onfig file [s]am/init.lua
vim.keymap.set('n', '<leader>cs', '<cmd>:edit ~/.config/nvim/lua/sam/init.lua<CR>')

-- Open the [c]onfig file [p]lugins/init.lua
vim.keymap.set('n', '<leader>cp', '<cmd>:edit ~/.config/nvim/lua/plugins/init.lua<CR>')

-- Use the system clipboard
vim.cmd([[set clipboard=unnamed]])

-- Use spaces instead of tabs
vim.cmd([[set expandtab]])
