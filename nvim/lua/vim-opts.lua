-- indenting
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.cindent = true
vim.opt.autoindent = true
-- vim.opt.softtabstop = 4

vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

-- Numbers
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.ruler = false

-- goto begnning and end
vim.keymap.set("i", "<C-b>", "<Esc>^i", {})
vim.keymap.set("i", "<C-e>", "<end>", {})

-- insert mode movement
vim.keymap.set("i", "<C-h>", "<Left>", {})
vim.keymap.set("i", "<C-l>", "<Right>", {})
vim.keymap.set("i", "<C-j>", "<Down>", {})
vim.keymap.set("i", "<C-k>", "<Up>", {})

-- move between windows
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})

-- tmux addition to move between panes
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", {})
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", {})
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", {})
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", {})

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", {})
-- copy all file content
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", {})

-- line number
vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>", {})
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", {})

-- move down and center
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true })
-- move up and center
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true })
-- keep yank on reg
vim.api.nvim_set_keymap("x", "<leader>p", "\"_dP", { noremap = true })

-- move to last buffer
vim.keymap.set("n", "<leader>b", "<cmd>:b#<CR>", { desc = "Move to the last buffer" })
-- new buffer
-- vim.keymap.set("n", "<leader>b", "<cmd> new <CR>", {})


-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })


-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- folke/trouble.nvim mapping
vim.keymap.set("n", "<leader>e", function()
  require("trouble").toggle("diagnostics")
end)

-- diagnostic
vim.diagnostic.config({
  virtual_text = true
})

-- Define background and color palette based on your provided colors
vim.opt.background = "dark"
