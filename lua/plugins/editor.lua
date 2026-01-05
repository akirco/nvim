local plugins = {
  {
    'echasnovski/mini.pairs',
    version = false,
    enabled = false,
    config = function()
      require('mini.pairs').setup({
        modes = { insert = true, command = false, terminal = false },
        mappings = {
          ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
          ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
          ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },
          [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
          [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
          ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },
          ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
          ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
          ['`'] = { action = 'closeopen', pair = '`', neigh_pattern = '[^\\].', register = { cr = false } },
        },
      })
    end,
  },
  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require('mini.ai').setup({
        custom_textobjects = nil,
        mappings = {
          around = 'a',
          inside = 'i',
          around_next = 'an',
          inside_next = 'in',
          around_last = 'al',
          inside_last = 'il',
          goto_left = 'g[',
          goto_right = 'g]',
        },
        n_lines = 50,
        search_method = 'cover_or_next',
        silent = true,
      })
    end,
  },
  {
    'kylechui/nvim-surround',
    version = '^3.0.0',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        padding = true,
        sticky = true,
        ignore = nil,
        toggler = {
          line = 'gcc',
          block = 'gbc',
        },
        opleader = {
          line = 'gc',
          block = 'gb',
        },
        extra = {
          above = 'gcO',
          below = 'gco',
          eol = 'gcA',
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = nil,
        post_hook = nil,
      })
    end,
  },
  {
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      max_time = 1000,
      max_count = 5,
      disable_mouse = false,
      hint = true,
      timeout = 3000,
      notification = true,
      allow_different_key = true,
      enabled = true,
      force_exit_insert_mode = false,
      max_insert_idle_ms = 5000,
      resetting_keys = {
        ['1'] = { 'n', 'x' },
        ['2'] = { 'n', 'x' },
        ['3'] = { 'n', 'x' },
        ['4'] = { 'n', 'x' },
        ['5'] = { 'n', 'x' },
        ['6'] = { 'n', 'x' },
        ['7'] = { 'n', 'x' },
        ['8'] = { 'n', 'x' },
        ['9'] = { 'n', 'x' },
        ['c'] = { 'n' },
        ['C'] = { 'n' },
        ['d'] = { 'n' },
        ['x'] = { 'n' },
        ['X'] = { 'n' },
        ['y'] = { 'n' },
        ['Y'] = { 'n' },
        ['p'] = { 'n' },
        ['P'] = { 'n' },
        ['gp'] = { 'n' },
        ['gP'] = { 'n' },
        ['.'] = { 'n' },
        ['='] = { 'n' },
        ['<'] = { 'n' },
        ['>'] = { 'n' },
        ['J'] = { 'n' },
        ['gJ'] = { 'n' },
        ['~'] = { 'n' },
        ['g~'] = { 'n' },
        ['gu'] = { 'n' },
        ['gU'] = { 'n' },
        ['gq'] = { 'n' },
        ['gw'] = { 'n' },
        ['g?'] = { 'n' },
      },
      restriction_mode = 'hint',
      restricted_keys = {
        ['h'] = { 'n', 'x' },
        ['j'] = { 'n', 'x' },
        ['k'] = { 'n', 'x' },
        ['l'] = { 'n', 'x' },
        ['+'] = { 'n', 'x' },
        ['gj'] = { 'n', 'x' },
        ['gk'] = { 'n', 'x' },
        ['<C-M>'] = { 'n', 'x' },
        ['<C-N>'] = { 'n', 'x' },
        ['<C-P>'] = { 'n', 'x' },
      },
      disabled_keys = {
        ['<Up>'] = false,
        ['<Down>'] = false,
        ['<Left>'] = false,
        ['<Right>'] = false,
      },
      disabled_filetypes = {
        ['aerial'] = true,
        ['alpha'] = true,
        ['Avante'] = true,
        ['checkhealth'] = true,
        ['dapui.*'] = true,
        ['db.*'] = true,
        ['Diffview.*'] = true,
        ['Dressing.*'] = true,
        ['fugitive'] = true,
        ['help'] = true,
        ['httpResult'] = true,
        ['lazy'] = true,
        ['lspinfo'] = true,
        ['mason'] = true,
        ['minifiles'] = true,
        ['Neogit.*'] = true,
        ['neo%-tree.*'] = true,
        ['neotest%-summary'] = true,
        ['netrw'] = true,
        ['noice'] = true,
        ['notify'] = true,
        ['oil'] = true,
        ['prompt'] = true,
        ['qf'] = true,
        ['query'] = true,
        ['snacks_dashboard'] = true,
        ['TelescopePrompt'] = true,
        ['Trouble'] = true,
        ['trouble'] = true,
        ['VoltWindow'] = true,
        ['undotree'] = true,
        ['compilation'] = true,
      },
      ui = {
        enter = true,
        focusable = true,
        border = {
          style = 'rounded',
          text = {
            top = 'Hardtime Report',
            top_align = 'center',
          },
        },
        position = '50%',
        size = {
          width = '40%',
          height = '60%',
        },
      },
    },
  },
  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    enabled = true,
    config = function()
      local mc = require('multicursor-nvim')
      mc.setup()
      local set = vim.keymap.set
      set({ 'n', 'x' }, '<A-k>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.lineAddCursor(-1)
      end)
      set({ 'n', 'x' }, '<A-j>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.lineAddCursor(1)
      end)
      set({ 'n', 'x' }, '<A-h>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.lineSkipCursor(-1)
      end)
      set({ 'n', 'x' }, '<A-l>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.lineSkipCursor(1)
      end)
      set({ 'n', 'x' }, '<A-n>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.matchAddCursor(1)
      end)
      set({ 'n', 'x' }, '<A-s>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.matchSkipCursor(1)
      end)
      set({ 'n', 'x' }, '<A-q>', function()
        if not vim.b.mc_allowed then
          return
        end
        mc.toggleCursor()
      end)
      mc.addKeymapLayer(function(layerSet)
        if not vim.b.mc_allowed then
          return
        end
        layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
        layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)
        layerSet({ 'n', 'x' }, '<A-x>', mc.deleteCursor)
        layerSet('n', '<esc>', function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
            vim.cmd('nohlsearch')
            vim.cmd('redraw!')
          end
        end)
      end)
      local hl = vim.api.nvim_set_hl
      hl(0, 'MultiCursorCursor', { reverse = true })
      hl(0, 'MultiCursorVisual', { link = 'Visual' })
      hl(0, 'MultiCursorSign', { fg = '#9CDCFE' })
      hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      hl(0, 'MultiCursorDisabledCursor', { reverse = true })
      hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
      hl(0, 'MultiCursorDisabledSign', { fg = '#9CDCFE' })
    end,
  },
  {
    'echasnovski/mini.icons',
    version = false,
    config = function()
      require('mini.icons').setup()
    end,
  },
  {
    'thebigcicca/neokinds',
    config = function()
      local neokinds = require('neokinds')
      neokinds.setup({
        icons = {
          hint = '󰌶',
          info = '󰋽',
          warning = '󰀪',
          error = '󰅚',
        },
        completion_kinds = {
          Text = ' ',
          Method = '󰆧',
          Function = '󰊕',
          Constructor = ' ',
          Field = '',
          Variable = ' ',
          Class = '󰠱 ',
          Interface = ' ',
          Module = ' ',
          Property = '󰜢 ',
          Unit = ' ',
          Value = ' ',
          Enum = '',
          Keyword = '󰌋',
          Snippet = '',
          Color = ' ',
          File = ' ',
          Reference = ' ',
          Folder = ' ',
          EnumMember = ' ',
          Constant = ' ',
          Struct = '',
          Event = ' ',
          Operator = ' ',
          TypeParameter = ' ',
          Boolean = ' ',
          Array = ' ',
        },
      })
    end,
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },
  {
    'chrisgrieser/nvim-recorder',
    dependencies = 'rcarriga/nvim-notify',
    opts = {},
  },
}

return plugins