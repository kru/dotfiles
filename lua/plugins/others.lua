local M = {
  {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    lazy = false,
    opts = {}
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
  init = function()
    require("customs.utils").lazy_load("indent-blankline.nvim")
  end,
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {
      -- indentLine_enabled = 1,
      exclude = {
        buftypes = { "terminal" },
        filetypes = {
          "zig",
          "c",
          "rust",
          "go",
          "javascript",
          "typescript",
          "lua",
          "help",
          "terminal",
          "lazy",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
        }
      },
      -- show_trailing_blankline_indent = false,
      -- show_first_indent_level = false,
      -- show_current_context = true,
      -- show_current_context_start = true,
      whitespace = {
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    },
    config = function(_, opts)
      require("ibl").setup(opts)
    end
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  -- autopairing of (){}[] etc
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require "nvim-autopairs.completion.cmp"
      require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "wakatime/vim-wakatime",
    lazy = false,
    priority = 1000,
  },
  -- disable options on first load, after none-ls installed, enable again
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function()
      return require("customs.none-ls")
    end
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "customs.dapcpp"
    end
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require "customs.dapgo"
    end
  },
  {
    {
      'akinsho/toggleterm.nvim',
      version = "*",
      opts = {
        direction = 'float',
        float_opts = {
          border = "curved",
          width = 120,
          height = 30,
          windblend = 3
        }
        --[[ things you want to change go here]] }
    }
  }
}

return M
