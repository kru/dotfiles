return {
	{

		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- NOTE: If you are having trouble with this installation,
				--       refer to the README for telescope-fzf-native for more instructions.
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
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
						width = 0.7,
					},
				},
				sorting_strategy = "ascending",
				initial_mode = "insert",
				file_ignore_patterns = { "node_modules", "dist" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
			},
		},
		config = function(_, opts)
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
			vim.keymap.set("n", "<leader>ls", builtin.oldfiles, { desc = "[?] Find recently opened files" })
			vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			require("telescope").setup(opts)
		end,
	},
	{

		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			extensions = {
				file_browser = {
					-- theme = "ivy",
					-- disables netrw and use telescope-file-browser in its place
					-- hijack_netrw = true,
					mappings = {},
					initial_mode = "insert",
				},
			},
		},
		config = function(_, opts)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>fb",
				":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				{ noremap = true }
			)
			require("telescope").setup(opts)
			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("fzf")
		end,
	},
}
