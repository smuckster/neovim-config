-- Set the leader key to space
vim.g.mapleader = ' '

-- Set tabs to 4 spaces
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Use block cursor in insert mode
vim.o.guicursor = ""

-- Shortcut for opening file explorer ([f]ile [e]xplorer)
--vim.keymap.set('n', '<leader>fe', function()
--	vim.cmd([[Explore]])
--end)

-- Return from file explorer to last open buffer ([b]ack to [b]uffer)
vim.keymap.set('n', '<leader>bb', function()
	vim.cmd([[b#]])
end)

-- Recenter page when jumping up and down
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

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
