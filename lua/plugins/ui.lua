local plugins = {
  {
    'Ferouk/bearded-nvim',
    name = 'bearded',
    priority = 1000,
    lazy = false,
    build = function()
      local doc = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy', 'bearded', 'doc')
      pcall(vim.cmd, 'helptags ' .. doc)
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local bearded = require('bearded')
      require('lualine').setup({
        options = {
          theme = require('bearded.plugins.lualine').theme(bearded.palette()),
        },
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = {
      'moll/vim-bbye',
      'nvim-tree/nvim-web-devicons',
    },
    enabled = true,
    config = function()
      require('bufferline').setup({
        options = {
          mode = 'tabs',
          themable = true,
          numbers = 'none',
          close_command = 'Bdelete! %d',
          buffer_close_icon = '',
          close_icon = '',
          path_components = 1,
          modified_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
          max_name_length = 30,
          max_prefix_length = 30,
          tab_size = 21,
          diagnostics = false,
          diagnostics_update_in_insert = false,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = { '.', '.' },
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          show_tab_indicators = true,
          indicator = {
            style = 'underline',
          },
          icon_pinned = '󰐃',
          minimum_padding = 1,
          maximum_padding = 5,
          maximum_length = 15,
          sort_by = 'id',
          offsets = {},
        },
        highlights = {
          separator = {
            fg = '#1f1f1f',
            bg = 'NONE',
          },
          separator_selected = {
            fg = '#1f1f1f',
            bg = 'NONE',
          },
          separator_visible = {
            fg = '#1f1f1f',
            bg = 'NONE',
          },
          tab_separator = {
            fg = '#1f1f1f',
            bg = 'NONE',
          },
          offset_separator = {
            bg = 'NONE',
            fg = '#1f1f1f',
          },
          buffer_selected = {
            fg = '#ffff00',
            bg = 'NONE',
            italic = false,
            bold = true,
          },
          modified = {
            fg = '#D7BA7D',
            bg = 'NONE',
          },
          modified_visible = {
            fg = '#D7BA7D',
            bg = 'NONE',
          },
          modified_selected = {
            fg = '#D7BA7D',
            bg = 'NONE',
          },
          buffer_visible = {
            fg = '#9d9d9d',
            bg = 'NONE',
          },
          background = {
            fg = '#9d9d9d',
            bg = 'NONE',
          },
          close_button = {
            fg = '#9d9d9d',
            bg = 'NONE',
          },
          close_button_visible = {
            fg = '#9d9d9d',
            bg = 'NONE',
          },
          close_button_selected = {
            fg = '#9d9d9d',
            bg = 'NONE',
          },
          fill = {
            bg = 'NONE',
          },
          indicator_selected = {
            fg = '#00aaff',
          },
        },
      })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    enabled = true,
    config = function()
      require('colorizer').setup()
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'DelimOrange',
          'DelimPink',
          'DelimBlue',
        },
        condition = function()
          return not vim.b.large_buf
        end,
      }
    end,
  },
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>no", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
      { "<leader>nc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
      { "<leader>nr", "<cmd>Neominimap Refresh<cr>", desc = "Refresh global minimap" },
      { "<leader>nwt", "<cmd>Neominimap WinToggle<cr>", desc = "Toggle minimap for current window" },
      { "<leader>nwr", "<cmd>Neominimap WinRefresh<cr>", desc = "Refresh minimap for current window" },
      { "<leader>nwo", "<cmd>Neominimap WinEnable<cr>", desc = "Enable minimap for current window" },
      { "<leader>nwc", "<cmd>Neominimap WinDisable<cr>", desc = "Disable minimap for current window" },
      { "<leader>ntt", "<cmd>Neominimap TabToggle<cr>", desc = "Toggle minimap for current tab" },
      { "<leader>ntr", "<cmd>Neominimap TabRefresh<cr>", desc = "Refresh minimap for current tab" },
      { "<leader>nto", "<cmd>Neominimap TabEnable<cr>", desc = "Enable minimap for current tab" },
      { "<leader>ntc", "<cmd>Neominimap TabDisable<cr>", desc = "Disable minimap for current tab" },
      { "<leader>nbt", "<cmd>Neominimap BufToggle<cr>", desc = "Toggle minimap for current buffer" },
      { "<leader>nbr", "<cmd>Neominimap BufRefresh<cr>", desc = "Refresh minimap for current buffer" },
      { "<leader>nbo", "<cmd>Neominimap BufEnable<cr>", desc = "Enable minimap for current buffer" },
      { "<leader>nbc", "<cmd>Neominimap BufDisable<cr>", desc = "Disable minimap for current buffer" },
      { "<leader>nf", "<cmd>Neominimap Focus<cr>", desc = "Focus on minimap" },
      { "<leader>nu", "<cmd>Neominimap Unfocus<cr>", desc = "Unfocus minimap" },
      { "<leader>ns", "<cmd>Neominimap ToggleFocus<cr>", desc = "Switch focus on minimap" },
    },
    init = function()
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36
      vim.g.neominimap = {
        auto_enable = true,
        buf_filter = function(bufnr)
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          local buftype = vim.api.nvim_buf_get_option(bufnr, 'buftype')
          return bufname ~= "" and buftype == ""
        end,
        float = {
          window_border = "none",
          minimap_width = 12,
        },
        split = {
          minimap_width = 12,
        },
      }
    end,
  },
  {
    'rcarriga/nvim-notify',
    lazy = false,
    enabled = true,
    config = function()
      local notify = require('notify')
      vim.notify = notify
      notify.setup({
        background_colour = '#1f1f1f',
        fps = 30,
        icons = {
          DEBUG = '',
          ERROR = '󰅚',
          INFO = '󰋽',
          TRACE = '',
          WARN = '󰀪',
        },
        level = 2,
        minimum_width = 50,
        render = 'default',
        stages = 'fade_in_slide_out',
        time_formats = {
          notification = '%T',
          notification_history = '%FT%T',
        },
        timeout = 5000,
        top_down = true,
        position = 'bottom_right',
      })
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup({
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
        },
        views = {
          cmdline_popup = {
            position = {
              row = '30%',
              col = '50%',
            },
          },
        },
        messages = {
          enabled = true,
          view = 'notify',
          view_error = 'notify',
          view_warn = 'notify',
          view_history = 'messages',
          view_search = 'virtualtext',
        },
        popupmenu = {
          enabled = true,
          backend = 'nui',
        },
        notify = {
          enabled = true,
          view = 'notify',
        },
        lsp = {
          progress = {
            enabled = true,
            format = 'lsp_progress',
            format_done = 'lsp_progress_done',
            throttle = 1000 / 30,
            view = 'mini',
          },
          hover = {
            enabled = true,
            silent = false,
            view = nil,
            opts = {},
          },
          signature = {
            enabled = true,
            auto_open = {
              enabled = true,
              trigger = true,
              luasnip = true,
              throttle = 50,
            },
            view = nil,
            opts = {},
          },
          message = {
            enabled = true,
            view = 'notify',
            opts = {},
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
      })
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'classic',
      delay = 300,
      filter = nil,
      spec = {
        ['<leader>'] = {
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
          b = {
            name = 'Buffer',
            d = 'Delete buffer',
          },
          w = {
            name = 'Write/Close',
            w = 'Save file',
            d = 'Save without formatting',
            c = 'Close current file',
          },
          d = {
            name = 'Diagnostics',
            d = 'Toggle diagnostics',
            f = 'Open diagnostics float',
          },
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
          c = {
            name = 'Code',
            a = 'Code actions',
          },
          t = {
            name = 'Theme',
            t = 'Toggle bearded flavor',
          },
          ['<Up>'] = 'Resize up',
          ['<Down>'] = 'Resize down',
          ['<Left>'] = 'Resize left',
          ['<Right>'] = 'Resize right',
          e = 'Open file browser',
          E = 'Toggle file browser',
        },
        [''] = {
          m = 'Set mark',
          n = 'Next search result (centered)',
          N = 'Previous search result (centered)',
          p = 'Paste without overwriting register',
        },
      },
      notify = false,
      triggers = {'<leader>'},
      defer = nil,
      plugins = {
        marks = true,
        registers = true,
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
      win = {
        padding = { 1, 2 },
        title = false,
        border = 'rounded',
        zindex = 1000,
        wo = {
          winblend = 0,
        },
      },
      layout = {
        width = { min = 20, max = 50 },
        spacing = 3,
        align = 'left',
      },
      keys = {
        scroll_down = '<c-d>',
        scroll_up = '<c-u>',
      },
      sort = { 'local', 'group' },
      expand = nil,
      replace = nil,
      icons = {
        breadcrumb = '»',
        separator = '➜',
        group = '+',
      },
      show_help = true,
      show_keys = true,
      disable = {
        filetypes = {},
        buftypes = {},
      },
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
      wk.register(opts.spec)
    end,
  },
  {
    "Layxe/comment-divider.nvim",
    init = function()
      local comment_divider = require("comment-divider")
      comment_divider.setup({
        c    = { "/*", "*/" },
        vhdl = "--",
      })

      local function create_section_divider()
        comment_divider.insert_divider("#", 100)
      end

      local function create_section_divider_centered_text()
        comment_divider.insert_divider_centered_text("-+-", 80)
      end

      vim.keymap.set("n", "<A-d>", create_section_divider)
      vim.keymap.set("n", "<A-x>", create_section_divider_centered_text)
      vim.keymap.set("i", "<A-d>", create_section_divider)
      vim.keymap.set("i", "<A-x>", create_section_divider_centered_text)
    end,
  },
  {
    'ThePrimeagen/vim-be-good',
    config = function() end,
  },
}

return plugins