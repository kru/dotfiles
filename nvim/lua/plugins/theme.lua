-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme "habamax"
	-- 	local tokyonight = require("tokyonight")
	-- 	tokyonight.setup({
	-- 		style = "moon",
	-- 		light_style = "moon",
	-- 		terminal_color = true,
	-- 		-- disable italic for functions
	-- 		styles = {
	-- 			functions = { italic = false },
	-- 			keywords = { italic = false },
	-- 		},
	-- 	})
-- 	end
-- }

return {
	'arcticicestudio/nord-vim',
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "nord"
		-- require("nordic").load()
	end
}

-- return {
-- 	"rose-pine/neovim",
-- 	name = "rose-pine",
-- 	config = function()
-- 		vim.cmd.colorscheme "rose-pine"
-- 		require("rose-pine").setup({
-- 			variant = "main",    -- auto, main, moon, or dawn
-- 			dark_variant = "main", -- main, moon, or dawn
-- 			dim_inactive_windows = false,
-- 			extend_background_behind_borders = true,
--
-- 			enable = {
-- 				terminal = true,
-- 				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
-- 				migrations = true,        -- Handle deprecated options automatically
-- 			},
--
-- 			styles = {
-- 				italic = false,
-- 				bold = false,
-- 				transparency = false,
-- 			},
-- 		})
-- 	end
-- }

-- return {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme "catppuccin-frappe"
-- 		require("catppuccin").setup({
-- 			flavour = "frappe", -- latte, frappe, macchiato, mocha
-- 			background = { -- :h background
-- 				light = "latte",
-- 				dark = "mocha",
-- 			},
-- 			transparent_background = false, -- disables setting the background color.
-- 			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
-- 			term_colors = false,   -- sets terminal colors (e.g. `g:terminal_color_0`)
-- 			dim_inactive = {
-- 				enabled = false,   -- dims the background color of inactive window
-- 				shade = "dark",
-- 				percentage = 0.15, -- percentage of the shade to apply to the inactive window
-- 			},
-- 			no_italic = false,     -- Force no italic
-- 			no_bold = false,       -- Force no bold
-- 			no_underline = false,  -- Force no underline
-- 		})
-- 	end
-- }
