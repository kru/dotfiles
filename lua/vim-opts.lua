-- indenting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

-- Numbers
vim.opt.number = true
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

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", {})
-- copy all file content
vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>", {})

-- line number
vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>", {})
vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>", {})

-- move to last buffer
vim.keymap.set("n", "<Tab>", "<cmd>:b#<CR>", {desc = "Move to the last buffer"})

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- new buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", {})

-- escape terminal mode
vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {})

-- toggle terminal
vim.keymap.set("n", "<A-i>", "<cmd>:ToggleTerm size=40 path=%:p:h direction=float<CR>", {})
vim.keymap.set("t", "<A-i>", "<cmd>:ToggleTerm size=40 path=%:p:h direction=float<CR>", {})

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
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updooetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- DAP custom mapping
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line"})
vim.keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continu the debugger"})
vim.keymap.set("n", "<F1>", "<cmd> DapStepOver <CR>", { desc = "Step over"})
vim.keymap.set("n", "<F2>", "<cmd> DapContinue <CR>", { desc = "Step continue"})
