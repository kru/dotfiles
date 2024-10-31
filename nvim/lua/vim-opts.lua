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

-- move to last buffer
vim.keymap.set("n", "<leader>b", "<cmd>:b#<CR>", { desc = "Move to the last buffer" })
-- new buffer
-- vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", {})


-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
vim.keymap.set("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })

-- escape terminal mode
vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), {})

-- toggle terminal
vim.keymap.set("n", "<leader>i", "<cmd>:ToggleTerm size=40 path=%:p:h direction=float<CR>", {})
vim.keymap.set("t", "<leader>i", "<cmd>:ToggleTerm size=40 path=%:p:h direction=float<CR>", {})

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

-- DAP custom mapping
vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
vim.keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Run or continu the debugger" })
vim.keymap.set("n", "<F1>", "<cmd> DapStepOver <CR>", { desc = "Step over" })
vim.keymap.set("n", "<F2>", "<cmd> DapContinue <CR>", { desc = "Step continue" })

-- folke/trouble.nvim mapping
vim.keymap.set("n", "<leader>e", function()
  require("trouble").toggle("workspace_diagnostics")
end)

-- Define background and color palette based on your provided colors
vim.opt.background = "dark"
vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "refined_soft_elegance"

-- Color definitions
-- local colors = {
--   fg         = "#e4e4e4", -- Soft Foreground
--   fg_plus1   = "#f4f4ff", -- Lighter Foreground
--   fg_plus2   = "#f5f5f5", -- Slightly Dimmed Foreground
--   white      = "#ffffff", -- Pure White (use sparingly)
--   black      = "#000000", -- Pure Black
--   bg_minus1  = "#101010", -- Dark Background
--   bg         = "#181818", -- Background
--   bg_plus1   = "#282828", -- Slightly Lighter Background
--   bg_plus2   = "#453d41", -- Lighter Background Accent
--   bg_plus3   = "#484848", -- Muted Accent Background
--   bg_plus4   = "#52494e", -- Softer Accent Background
--   red_minus1 = "#c73c3f", -- Muted Red
--   red        = "#f43841", -- Primary Red Accent (use minimally)
--   red_plus1  = "#ff4f58", -- Brighter Red (use minimally)
--   green      = "#73d936", -- Soft Green
--   yellow     = "#ffdd33", -- Soft Yellow
--   brown      = "#cc8c3c", -- Muted Brown
--   quartz     = "#95a99f", -- Soft Neutral Grey
--   niagara2   = "#303540", -- Dark Blue-Grey
--   niagara1   = "#565f73", -- Muted Blue-Grey
--   niagara    = "#96a6c8", -- Soft Blue
--   wisteria   = "#9e95c7", -- Muted Purple
--   gold       = "#d4af37", -- Muted Gold for Data Types
--   teal       = "#5e9a8b", -- Muted Teal for Keywords
-- }
--
-- -- Helper function to set highlights
-- local function highlight(group, fg, bg, attr)
--   local cmd = "highlight " .. group .. " guifg=" .. (fg or "NONE") ..
--       " guibg=" .. (bg or "NONE") ..
--       " gui=" .. (attr or "NONE")
--   vim.cmd(cmd)
-- end
--
-- -- Apply highlights for an elegant, balanced look
-- highlight("Normal", colors.fg, colors.bg)
-- highlight("Comment", colors.quartz, nil, "italic")
-- highlight("Keyword", colors.yellow)
-- highlight("String", colors.green)
-- highlight("Function", colors.teal)
-- highlight("Identifier", colors.niagara)
-- highlight("Type", colors.gold)
-- highlight("StorageClass",  colors.gold)        -- C storage classes in gold
-- highlight("TypeBuiltin",   colors.gold)        -- Builtin types in gold
-- highlight("Constant",      colors.gold)        -- Constants in gold
-- highlight("Structure",      colors.yellow)
-- highlight("Special",      colors.wisteria) -- int, char, float
-- highlight("SpecialChar",      colors.gold)
-- highlight("Visual", nil, colors.bg_plus3)
-- highlight("LineNr", colors.quartz, colors.bg)
-- highlight("CursorLineNr", colors.fg_plus1, colors.bg)
-- highlight("StatusLine", colors.fg, colors.bg_plus1)
-- highlight("Pmenu", colors.fg, colors.bg_plus2)
-- highlight("PmenuSel", colors.fg, colors.niagara)
-- highlight("Search", colors.bg, colors.niagara1)
-- highlight("IncSearch", colors.bg, colors.niagara2)
-- highlight("MatchParen", colors.fg_plus1, colors.bg_plus4)
-- highlight("Todo", colors.yellow, nil, "bold")
-- highlight("Error", colors.red_minus1, nil, "bold")
-- highlight("WarningMsg", colors.brown, nil, "bold")

-- LSP diagnostics in a softer color scheme
-- highlight("DiagnosticError", colors.red_minus1)
-- highlight("DiagnosticWarn", colors.yellow)
-- highlight("DiagnosticInfo", colors.niagara)
-- highlight("DiagnosticHint", colors.quartz)
-- Define color palette based on the image
local colors = {
  fg         = "#e4e4e4", -- Soft Foreground for main text
  white      = "#ffffff", -- Pure White for variables
  black      = "#000000", -- Pure Black (not commonly used)
  bg         = "#181818", -- Background
  gray       = "#95a99f", -- Gray for comments
  blue       = "#96a6c8", -- Blue for keywords
  light_blue = "#b0c9ff", -- Light blue for data types
  orange     = "#cc8c3c", -- Orange for function names
  green      = "#73d936", -- Green for strings
  yellow     = "#ffdd33", -- Yellow for specific text in strings if needed
}

-- Helper function to set highlights
local function highlight(group, fg, bg, attr)
  local cmd = "highlight " .. group .. " guifg=" .. (fg or "NONE") ..
              " guibg=" .. (bg or "NONE") ..
              " gui=" .. (attr or "NONE")
  vim.cmd(cmd)
end

-- Apply highlights
highlight("Normal", colors.fg, colors.bg)
highlight("Comment", colors.gray, nil, "italic")          -- Comments in gray
highlight("Keyword", colors.blue)                         -- Keywords in blue
highlight("Type", colors.light_blue)                      -- Data types in light blue
highlight("Function", colors.orange)                      -- Function names in orange
highlight("Identifier", colors.white)                     -- Variables in white
highlight("String", colors.green)                         -- Strings in green
highlight("Special", colors.light_blue)                   -- For special keywords if needed
highlight("Constant", colors.yellow)                      -- Constants in yellow

-- Line and other interface elements for balance
highlight("LineNr", colors.gray, colors.bg)
highlight("CursorLineNr", colors.white, colors.bg)
highlight("StatusLine", colors.fg, colors.bg)
highlight("Pmenu", colors.fg, colors.bg_plus2)
highlight("PmenuSel", colors.fg, colors.blue)
highlight("Visual", nil, colors.gray)
highlight("Search", colors.bg, colors.blue)
highlight("IncSearch", colors.bg, colors.orange)
highlight("MatchParen", colors.fg, colors.bg)

-- Diagnostic and error colors
highlight("DiagnosticError", colors.red_minus1)
highlight("DiagnosticWarn", colors.yellow)
highlight("DiagnosticInfo", colors.blue)
highlight("DiagnosticHint", colors.gray)

