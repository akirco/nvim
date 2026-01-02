return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- Layout style
    preset = 'classic', -- "classic", "modern", or "helix"

    -- Delay before popup appears (ms)
    delay = 300,

    -- Filter function to exclude mappings
    filter = nil,

    -- Initial table for user-defined mappings
    spec = {
      ['<leader>'] = {
        -- Window management
        s = {
          name = 'Split',
          v = 'Split vertically',
          h = 'Split horizontally',
          e = 'Make splits equal',
        },
        x = {
          name = 'Close',
          x = 'Close current split',
        },
        r = {
          name = 'Resize',
          h = 'Resize left',
          j = 'Resize down',
          k = 'Resize up',
          l = 'Resize right',
        },
        -- Buffer management
        b = {
          name = 'Buffer',
          d = 'Delete buffer',
        },
        -- Terminal (disabled - using Ctrl+` instead)
        -- t = {
        --   name = 'Terminal',
        --   s = 'Open terminal at bottom',
        --   p = 'Run Python shell',
        --   n = 'Open terminal in current window',
        --   t = 'Toggle terminal',
        -- },
        -- File operations
        w = {
          name = 'Write/Close',
          w = 'Save file',
          d = 'Save without formatting',
          c = 'Close current file',
        },
        -- Diagnostics
        d = {
          name = 'Diagnostics',
          d = 'Toggle diagnostics',
          f = 'Open diagnostics float',
        },
        -- Telescope
        f = {
          name = 'Find',
          f = 'Find files',
          g = 'Live grep',
          b = 'Find buffers',
          k = 'Find keymaps',
          w = 'Find word under cursor',
          r = 'Find registers',
          h = 'Help tags',
          u = 'Undo tree',
        },
        S = {
          name = 'Spectre',
          S = 'Open Spectre search & replace',
          w = 'Search current word',
          f = 'Search in current file',
        },
        g = {
          name = 'Git',
          c = 'Git commits',
          b = 'Git buffer commits',
          m = 'Diff with staged (Meld)',
          M = 'Launch Meld as mergetool',
        },
        -- Code actions
        c = {
          name = 'Code',
          a = 'Code actions',
        },
        -- Colorscheme
        t = {
          name = 'Theme',
          t = 'Toggle theme',
          h = 'Toggle bearded flavor',
        },
        -- Window resize with arrow keys
        ['<Up>'] = 'Resize up',
        ['<Down>'] = 'Resize down',
        ['<Left>'] = 'Resize left',
        ['<Right>'] = 'Resize right',
        -- NvimTree
        e = 'Focus NvimTree',
        E = 'Toggle NvimTree',
      },
      [''] = {
        -- Single key mappings (no prefix)
        m = 'Set mark',
        n = 'Next search result (centered)',
        N = 'Previous search result (centered)',
        p = 'Paste without overwriting register',
      },
    },

    -- Show warnings for mapping issues
    notify = false,

    -- Configure how the popup is activated
    triggers = {'<leader>'}, -- specify list like {'<leader>', '<localleader>'}

    -- Control when to show popup after operator
    defer = nil,

    -- Built-in helpers
    plugins = {
      marks = true,      -- shows marks on ' and `
      registers = true,  -- shows registers on " and <C-r>
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },

    -- Window options
    win = {
      padding = { 1, 2 },
      title = false,
      border = 'rounded',
      zindex = 1000,
      wo = {
        winblend = 0,
      },
    },

    -- Layout options
    layout = {
      width = { min = 20, max = 50 },
      spacing = 3,
      align = 'left',
    },

    -- Keys for scrolling in popup
    keys = {
      scroll_down = '<c-d>',
      scroll_up = '<c-u>',
    },

    -- Sorting order for mappings
    sort = { 'local', 'group' },

    -- Auto-expand groups
    expand = nil,

    -- Formatting rules
    replace = nil,

    -- Icons settings
    icons = {
      breadcrumb = '»',
      separator = '➜',
      group = '+',
    },

    -- Show help and keys in command line
    show_help = true,
    show_keys = true,

    -- Disable for certain filetypes/buftypes
    disable = {
      filetypes = {},
      buftypes = {},
    },

    -- Debug logging
    debug = false,
  },
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)
    -- Register spec after setup to ensure it's loaded
    wk.register(opts.spec)
  end,
}