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
		'nvim-neo-tree/neo-tree.nvim',
		branch = 'v3.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			'MunifTanjim/nui.nvim',
		},
		config = function()
			require('neo-tree').setup({
				close_if_last_window = false, -- Close Neotree if it is the last window in the tab
				popup_border_style = 'rounded',
				enable_git_status = true,
				enable_normal_mode_for_inputs = false, -- Enable normal mode for input dialogs
				sort_case_insensitive = false,
				window = {
					position = 'left',
					width = 40,
				},
				hijack_netrw_behavior = 'open_default',
				use_libuv_file_watcher = false,
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = true,
						hide_gitignored = true,
						never_show = {
							-- 'node_modules'
						},
						follow_current_file = {
							enabled = true,
							leave_dirs_open = true,
						},
						group_empty_dirs = true,
					},
				},
				buffers = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = true,
					},
					group_entry_dirs = true,
				},
			})

			-- Toggle the [f]ile [t]ree
			vim.keymap.set('n', '<leader>ft', '<cmd>Neotree toggle<CR>')

			-- [f]ocus the [f]ile tree
			vim.keymap.set('n', '<leader>ff', '<cmd>Neotree reveal<CR>')

			-- Open [g]it [s]tatus window
			vim.keymap.set('n', '<leader>gs', '<cmd>Neotree float git_status<CR>')
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
				ensure_installed = {"php", "rust", "scss", "lua", "vim", "vimdoc", "javascript", "html" },
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

			-- Use MOODLE_ROOT env variable so LSP doesn't get confused by git modules
			local moodle_root = os.getenv("MOODLE_ROOT")
			if moodle_root ~= '' and moodle_root ~= nil then
				local rootdirectory = function(args)
					return moodle_root
				end

                -- Set up PHP language server
                require'lspconfig'.intelephense.setup{root_dir = rootdirectory}
			end

			require("symbols-outline").setup()

			-- Set up language servers
			-- JavaScript/TypeScript
			require'lspconfig'.tsserver.setup{}

            -- Rust
            require'lspconfig'.rust_analyzer.setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
		end,
	},

	--- Uncomment these if you want to manage LSP servers from neovim
	-- {
	--         'williamboman/mason.nvim',
	--         -- opts = {
	--         --     ensure_installed = {
	--         --         "rust-analyzer",
	--         --     }
	--         -- }
	--     },
	-- {'williamboman/mason-lspconfig.nvim'},

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
            -- Open a three-way diff set of windows for [m]erge [c]onflicts
            vim.keymap.set('n', '<leader>mc', '<cmd>Gvdiffsplit!<CR>')
		end,
	},

	{
		'vim-vdebug/vdebug',
		lazy = false,
		enabled = true,
		config = function()
			vim.keymap.set('n', '<leader>b', '<cmd>:python3 debugger.set_breakpoint()<CR>')
			vim.keymap.set('n', '<leader>dl', '<cmd>:python3 debugger.run()<CR>')

			vim.keymap.set('n', '<F2>', '<Nop>')
			vim.keymap.set('n', '<F2>', '<cmd>:python3 debugger.step_over()<CR>')

			vim.keymap.set('n', '<F3>', '<Nop>')
			vim.keymap.set('n', '<F3>', '<cmd>:python3 debugger.step_into()<CR>')

			vim.keymap.set('n', '<F4>', '<Nop>')
			vim.keymap.set('n', '<F4>', '<cmd>:python3 debugger.step_out()<CR>')
		end,
	},
	{
		'vim-test/vim-test',
		config = function()
			-- [t]est [n]earest
			vim.keymap.set('n', '<leader>tn', '<cmd>TestNearest<CR>')

			-- [t]est [f]ile
			vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<CR>')
		end,
	},
	{
		'mustache/vim-mustache-handlebars',
		config = function()

		end,
	},
	{
		'simrat39/symbols-outline.nvim',
		config = function()
			-- Open [o]utline
			vim.keymap.set('n', '<leader>o', '<cmd>SymbolsOutline<CR>')
		end,
	},
	{
		'm4xshen/autoclose.nvim',
		config = function()
			require('autoclose').setup()
		end,
	},
	{
		'terrortylor/nvim-comment',
		config = function()
			require('nvim_comment').setup()
			vim.keymap.set('n', '<C-_>', '<cmd>CommentToggle<CR>')
			vim.keymap.set('v','<C-_>', "gc", { remap = true })
		end,
	},
	{
		'airblade/vim-gitgutter',
		config = function()

		end,
	},
    {
        'f-person/git-blame.nvim',
        config = function()
            require('gitblame').setup {
                virtual_text_column = 80,
            }
            vim.keymap.set('n', '<leader>gb', '<cmd>GitBlameToggle<CR>')
        end,
    }
}
