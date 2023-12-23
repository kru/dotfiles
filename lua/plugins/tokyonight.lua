return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme "tokyonight-moon"
		local tokyonight = require("tokyonight")
		tokyonight.setup({
			style = "moon",
			light_style = "moon",
			terminal_color = true,
			-- disable italic for functions
			styles = {
				functions = {}
			},
		})
	end
}
