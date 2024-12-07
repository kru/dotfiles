return {
    "kru/judo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("judo").setup({
            contrast = "soft",
        })
        vim.cmd('colorscheme judo')
    end
}
