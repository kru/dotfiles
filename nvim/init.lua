-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.opt.updatetime = 100 -- Faster updates
vim.cmd("syntax sync minlines=50 maxlines=100")

require("vim-opts")
-- plugin start
require("lazy").setup({
  {
    "kru/judo.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("judo").setup({
        contrast = "soft",
      })
      vim.cmd('colorscheme judo')
    end
  },
  { -- Autoformat
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      -- format_on_save = {
      -- 	timeout_ms = 500,
      -- 	lsp_fallback = true,
      -- },
      formatters_by_ft = {
        lua = { "stylua" },
        -- Biome for JS/TS/JSON formatting
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        c = { "clang-format" },
        cpp = { "clang-format" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      }
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'echasnovski/mini.icons' },
    lazy = false,
    config = function()
      require("lualine").setup({
        options = {
          theme = "onedark",
          section_separators = "",
          component_separators = { left = "", right = "|" }
        }
      })
    end
  },
  {
    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",
  },
  -- Useful plugin to show you pending keybinds.
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = {},
  },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  -- mini.icons - lightweight icon provider (replaces nvim-web-devicons)
  {
    "echasnovski/mini.icons",
    lazy = false,
    opts = {},
    init = function()
      require("mini.icons").mock_nvim_web_devicons()
    end,
    config = function(_, opts)
      require("mini.icons").setup(opts)
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
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
      local finders = require("telescope.finders")
      local pickers = require("telescope.pickers")
      local make_entry = require("telescope.make_entry")

      -- Check if ripgrep is installed
      local has_rg = vim.fn.executable("rg") == 1

      local live_multigrep = function(opts)
        opts = opts or {}
        opts.cwd = opts.cwd or vim.uv.cwd()

        -- Fallback to builtin live_grep if ripgrep is not available
        if not has_rg then
          vim.notify("ripgrep (rg) not found. Falling back to builtin live_grep. Install ripgrep for better performance.", vim.log.levels.WARN)
          builtin.live_grep(opts)
          return
        end

        local finder = finders.new_async_job {
          command_generator = function(prompt)
            if not prompt or prompt == "" then
              return nil
            end

            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }
            if pieces[1] then
              table.insert(args, "-e")
              table.insert(args, pieces[1])
            end

            if pieces[2] then
              table.insert(args, "-g")
              table.insert(args, pieces[2])
            end

            --@diagnostic disable-next-line: deprecated
            return vim.tbl_flatten {
              args,
              { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            }
          end,
          entry_maker = make_entry.gen_from_vimgrep(opts),
          cwd = opts.cwd,
        }

        pickers.new(opts, {
          debounce = 100,
          prompt_title = "Live Multi Grep",
          finder = finder,
          previewer = require("telescope.config").values.grep_previewer(opts),
          sorter = require("telescope.sorters").empty(),
        }):find()
      end

      -- Helper to check rg for live_grep
      local live_grep_with_fallback = function(additional_args)
        if not has_rg then
          vim.notify("ripgrep (rg) not found. Install ripgrep for better search performance.", vim.log.levels.WARN)
        end
        builtin.live_grep(additional_args)
      end

      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fs', function()
        live_grep_with_fallback({ additional_args = { '--fixed-strings' } })
      end, { noremap = true, desc = '[F]ind [S]tring (fixed)' })
      vim.keymap.set('n', '<leader>fw', live_multigrep, { desc = '[F]ind [W]ord (multi-grep)' })
      vim.keymap.set('n', '<leader>ls', builtin.oldfiles,
        { desc = '[?] Find recently opened files' })
      vim.api.nvim_set_keymap("n", "<leader>lf",
        ":lua require('telescope.builtin').lsp_document_symbols({ symbols='function' })<CR>",
        { noremap = true })
      vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      require('telescope').setup(opts)
    end
  },
  -- Mason: LSP/DAP/Formatter/Linter package manager
  {
    "williamboman/mason.nvim",
    lazy = false, -- Load immediately (needed for LSP setup)
    opts = {
      ensure_installed = {
        "gopls",
        "gofumpt",
        -- Formatter/Linter: Biome (replaces eslint_d + prettier)
        "biome",
        "clangd",
        "clang-format",
        "rust-analyzer",
        "zls",
        "lua-language-server",
        "ols"
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  -- nvim-lspconfig: LSP configuration (required by typescript-tools and useful for other LSPs)
  {
    "neovim/nvim-lspconfig",
    lazy = false, -- Load immediately for LSP support
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of parsers to install (or "all" for everything)
        -- Explicitly excluding javascript
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "lua",
          "luadoc",
          "markdown",
          "markdown_inline",
          "odin",
          "python",
          "query",
          "regex",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "zig",
        },
        -- Ignore JavaScript parser
        ignore_install = { "javascript" },
        highlight = {
          enable = true,
          -- Disable highlighting for JavaScript files
          disable = { "javascript", "javascriptreact" },
        },
        indent = { enable = true },
      })
    end,
  },
  -- typescript-tools.nvim - TypeScript LSP
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim", 
      "neovim/nvim-lspconfig",
    },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      require("typescript-tools").setup({})
    end,
  },
})
-- plugin end
require("lsp-opts")
