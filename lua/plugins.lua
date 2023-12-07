local plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = {
          enable = true,
        },
      }
      require('configs.treesitter')
    end,
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --   },
  --   config = function()
  --     require("mason").setup()
  --     require("mason-lspconfig").setup()
  --     --
  --   end
  -- },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig")
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        styles = {       -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = {}, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = { "italic" },
          types = { "bold" },
          operators = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        custom_highlights = function(C)
          return {
            HopNextKey = { bg = C.text, fg = C.base, style = { "bold", "underline" } },
            HopNextKey1 = { bg = C.text, fg = C.base, style = { "bold" } },
            HopNextKey2 = { bg = C.text, fg = C.base, style = { "bold", "italic" } },
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          mini = true,
          mason = true,
          neogit = true,
          illuminate = false,
          -- noice = true,
          notify = true,
          flash = true,
          telescope = {
            enabled = true,
            style = "nvchad"
          },
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
          },
          indent_blankline = {
            enabled = true,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
        },
      })
    end,
  },
  -- {
  --   "Shatur/neovim-ayu",
  --   config = function()
  --     require('ayu').setup({
  --       options = {
  --         theme = 'ayu',
  --       },
  --     })
  --   end,
  -- },
  -- Install without configuration
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- cmp sources plugins
      {
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",

        {
          "L3MON4D3/LuaSnip",
          dependencies = {
            "rafamadriz/friendly-snippets",
          },
          init = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end

        },
        'saadparwaiz1/cmp_luasnip'
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = { "Copilot" },
    opts = {
      suggestion = {
        auto_trigger = true,
      },
      filetypes = {
        markdown = true,
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- 'arkav/lualine-lsp-progress',
    },
    config = function()
      require('lualine').setup(require("configs.lualine"))
    end
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    config = function()
      require("bufferline").setup {
        highlights = require("catppuccin.groups.integrations.bufferline").get()
      }
    end
  },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require("Comment").setup()
    end,

  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup({
        use_default_keymaps = false,
        max_join_length = 1200,
      })
    end,
  },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup()
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup()
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      require('mini.files').setup()
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
          map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
          map('v', '<leader>hs', function()
              gs.stage_hunk { vim.fn.line(
                '.'
              ), vim.fn.line('v') }
            end,
            { desc = "Stage hunk" })
          map(
            'v',
            '<leader>hr',
            function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "Reset hunk" }
          )
          map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
          map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
          map(
            'n',
            '<leader>hb',
            function() gs.blame_line { full = true } end,
            { desc = "Blame line" }
          )
          map(
            'n',
            '<leader>tb',
            gs.toggle_current_line_blame,
            { desc = "Toggle current line blame" }
          )
          map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this (ignore whitespace)" })
          map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
        end
      })
    end,
  },
  {
    "sustech-data/wildfire.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("wildfire").setup({
        keymaps = {
          init_selection = "<space>",
          node_incremental = "<space>",
          node_decremental = "<c-space>",
        }
      }
      )
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },
  {
    'michaelb/sniprun',
    -- run = 'sh ./install.sh',
    config = function()
      require('sniprun').setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
        },
        delay = 100,
      })
    end
  },
  { "ofseed/lualine-copilot" },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     messages = {
  --       view = "mini",             -- default view for messages
  --       view_error = "notify",     -- view for errors
  --       view_warn = "notify",      -- view for warnings
  --       view_history = "messages", -- view for :messages
  --       view_search = "mini",      -- view for search count messages. Set to `false` to disable
  --     },
  --     cmdline = {
  --       view = "cmdline",
  --     },
  --     views = {
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --       },
  --     },
  --     presets = {
  --       -- you can enable a preset by setting it to true, or a table that will override the preset config
  --       -- you can also add custom presets that you can enable/disable with enabled=true
  --       bottom_search = true, -- use a classic bottom cmdline for search
  --     },
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     "rcarriga/nvim-notify",
  --   }
  -- },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "minimal",
      stages = "static",
    }
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
      uppercase_labels = true,
    },
  },
}

return plugins
