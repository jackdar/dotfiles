return {
  { -- Catppuccin theme for Neovim
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        integrations = {
          cmp = true,
          fidget = true,
          gitsigns = true,
          harpoon = true,
          indent_blankline = {
            enabled = false,
            scope_color = 'sapphire',
            colored_indent_levels = false,
          },
          mason = true,
          native_lsp = { enabled = true },
          noice = true,
          notify = true,
          symbols_outline = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
        },
        transparent_background = true,
      }

      -- Hide all semantic highlights until upstream issues are resolved (https://github.com/catppuccin/nvim/issues/480)
      for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
        vim.api.nvim_set_hl(0, group, {})
      end
    end,
  },
  { -- Gruvbox theme for Neovim
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('gruvbox').setup {
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = '', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
      }
    end,
  },
  {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup {
        transparent = true,
        disable_background = true,
      }
    end,
  },
}
