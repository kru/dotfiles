return {
	{

		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
		},
		opts = {
			defaults = {
				mappings = {},
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
						width = function(_, max_columns)
							local percentage = 0.8
							local max = 120
							return math.min(math.floor(percentage * max_columns), max)
						end,
						height = function(_, _, max_lines)
							local percentage = 0.8
							local min = 120
							return math.max(math.floor(percentage * max_lines), min)
						end
					},
				},
				sorting_strategy = "ascending",
				initial_mode = "insert",
				file_ignore_patterns = { "node_modules" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
			},
		},
		config = function(_, opts)
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fs', builtin.grep_string, {})
			vim.keymap.set('n', '<leader>ls', builtin.oldfiles,
				{ desc = '[?] Find recently opened files' })
			vim.api.nvim_set_keymap("n", "<leader>lf", ":lua require('telescope.builtin').lsp_document_symbols({ symbols='function' })<CR>",
				{ noremap = true })
			vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
			require('telescope').setup(opts)
		end
	},
	{

		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim"
		},
		opts = {
			extensions = {
				file_browser = {
					-- theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					-- hijack_netrw = true,
					mappings = {
					},
					initial_mode = "insert",
				},
			},
		},
		config = function(_, opts)
			vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				{ noremap = true })
			require("telescope").setup(opts)
			require("telescope").load_extension "file_browser"
		end
	}
}
