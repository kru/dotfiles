return {
	'kru/judo.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require("judo").setup({
			contracts = "soft",
		})
		vim.o.background = "dark"
		vim.cmd.colorscheme "judo"
	end
}
