-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd.colorscheme "tokyonight-moon"
-- 		local tokyonight = require("tokyonight")
-- 		tokyonight.setup({
-- 			style = "moon",
-- 			light_style = "moon",
-- 			terminal_color = true,
-- 			-- disable italic for functions
-- 			styles = {
-- 				functions = {}
-- 			},
-- 		})
-- 	end
-- }
return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd.colorscheme "rose-pine"
		require("rose-pine").setup({
			variant = "auto",    -- auto, main, moon, or dawn
			dark_variant = "main", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = true,

			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true,        -- Handle deprecated options automatically
			}
		})
	end
}
