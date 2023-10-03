return {
	{ 
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000 ,
		config = function()
			-- load colorscheme here
			vim.cmd([[colorscheme catppuccin]])

			-- update the line numbering colors
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#9CA0B0', bold = true })
			vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#9CA0B0' })
			vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#9CA0B0' })
		end,

	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			-- disable netrw at the very start of your init.lua
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			-- set termguicolors to enable highlight groups
			vim.opt.termguicolors = true

			vim.keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<CR>') -- toggle [f]ile [t]ree
			vim.keymap.set('n', '<leader>fo', '<cmd>NvimTreeFocus<CR>') -- [f]ile explorer [o]pen and focus
			vim.keymap.set('n', '<leader>ff', '<cmd>NvimFindFile<CR>') -- [f]ind the current [f]ile in the tree
			vim.keymap.set('n', '<leader>fc', '<cmd>NvimTreeCollapse<CR>') -- [f]ile tree [c]ollapse

			-- OR setup with some options
			require("nvim-tree").setup({
				sort_by = "case_sensitive",
				view = {
					width = 36,
				},
				renderer = {
					group_empty = true,
				},
				filters = {
					dotfiles = true,
				},
			})
		end,
	},
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.3',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
			vim.keymap.set('n', '<leader>pg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {"php", "lua", "vim", "vimdoc", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },  
			})
		end
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>')
		end
	},
	{
		'VonHeikemen/lsp-zero.nvim', 
		branch = 'v3.x',
		config = function()
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({buffer = bufnr})
	 		end)

			-- Set up language servers
			-- PHP
			require'lspconfig'.intelephense.setup{}
			-- require'lspconfig'.phpactor.setup{}

			-- JavaScript/TypeScript
			require'lspconfig'.tsserver.setup{}
		end,
	},

	--- Uncomment these if you want to manage LSP servers from neovim
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},

	-- LSP Support
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{'hrsh7th/cmp-nvim-lsp'},
		},
	},

	-- Autocompletion
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{'L3MON4D3/LuaSnip'},
		}
	},

	-- Fugitive Git wrapper
	{
		'tpope/vim-fugitive',
		config = function()

		end,
	},

	{
		'vim-vdebug/vdebug',
		lazy = false,
		enabled = true,
		config = function()
			-- vim.cmd('let g:vdebug_keymap = {"run": "<F5>","run_to_cursor": "<F6>","step_over": "<F7>","step_into": "<F8>","step_out": "<S-F8>","close": "<F4>","detach": "<F2>","set_breakpoint": "<leader>b"}')
			-- vim.cmd("let g:vdebug_keymap['set_breakpoint'] = '<leader>b'")
			-- vim.g.vdebug_keymap['set_breakpoint'] = '<leader>b'
			-- vim.keymap.set('n', '<leader>b', '<cmd>:Breakpoint<CR>')
			vim.keymap.set('n', '<leader>b', '<cmd>:python3 debugger.set_breakpoint()<CR>')
			vim.keymap.set('n', '<leader>dl', '<cmd>:python3 debugger.run()<CR>')

			vim.keymap.set('n', '<F2>', '<Nop>')
			vim.keymap.set('n', '<F2>', '<cmd>:python3 debugger.step_over()<CR>')
		end,
	},
	{
		'vim-test/vim-test',
		config = function()

		end,
	}
}
