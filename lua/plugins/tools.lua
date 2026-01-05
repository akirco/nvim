local plugins = {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    config = function()
      local toggleterm = require('toggleterm')

      toggleterm.setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        direction = 'horizontal',
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        persist_mode = true,
        float_opts = {
          border = 'rounded',
          width = function() return math.floor(vim.o.columns * 0.8) end,
          height = function() return math.floor(vim.o.lines * 0.8) end,
          winblend = 3,
        },
        highlights = {
          Normal = {
            link = 'Normal',
          },
          NormalFloat = {
            link = 'NormalFloat',
          },
          FloatBorder = {
            link = 'FloatBorder',
          },
        },
        auto_scroll = true,
        close_on_exit = true,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
      })

      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      keymap.set('n', '<C-`>', function()
        local Terminal = require('toggleterm.terminal').Terminal
        local term = Terminal:new({ direction = 'horizontal' })
        term:toggle()
      end, { desc = 'Toggle terminal panel (VSCode style)' })

      keymap.set('n', '<leader>tf', function()
        local Terminal = require('toggleterm.terminal').Terminal
        local term = Terminal:new({ direction = 'float' })
        term:toggle()
      end, { desc = 'Toggle floating terminal' })

      keymap.set('n', '<leader>tv', function()
        local Terminal = require('toggleterm.terminal').Terminal
        local term = Terminal:new({ direction = 'vertical' })
        term:toggle()
      end, { desc = 'Toggle vertical terminal' })

      keymap.set('n', '<leader>t2', function()
        local Terminal = require('toggleterm.terminal').Terminal
        local term = Terminal:new({ direction = 'horizontal' })
        term:toggle()
        local term2 = Terminal:new({ direction = 'horizontal' })
        term2:toggle()
      end, { desc = 'Open two terminal panels' })

      keymap.set('t', '<C-`>', '<Cmd>ToggleTerm<CR>', opts)
      keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
      keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end,
  },
  {
    "coffebar/neovim-project",
    opts = {
      projects = {
        "~/Projects/aigen/*",
        "~/Projects/android/*",
        "~/Projects/bun/*",
        "~/Projects/deno/*",
        "~/Projects/electron/*",
        "~/Projects/flutter/*",
        "~/Projects/golang/*",
        "~/Projects/lua/*",
        "~/Projects/markdown/*",
        "~/Projects/miniapp/*",
        "~/Projects/nextjs/*",
        "~/Projects/nodejs/*",
        "~/Projects/openplan/*",
        "~/Projects/powershell/*",
        "~/Projects/python/*",
        "~/Projects/reactjs/*",
        "~/Projects/repository/*",
        "~/Projects/rust/*",
        "~/Projects/shell/*",
        "~/Projects/tauri/*",
        "~/Projects/temp/*",
        "~/Projects/tui/*",
        "~/Projects/vuejs/*",
        "~/Projects/webapi/*",
        "~/Projects/workspaces/*",
        "~/Projects/zig/*"
      },
      picker = {
        type = "telescope",
      }
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
    config = function(_, opts)
      require("neovim-project").setup(opts)
      local keymap = vim.keymap
      local project = require("neovim-project.project")
      keymap.set("n", "<leader>pp", function()
        project.show_history()
      end, { desc = "Open project history" })
      keymap.set("n", "<leader>pl", function()
        project.discover_projects()
      end, { desc = "Discover projects" })
    end,
  },
  {
    'Jason-Bai/search-replace.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
    },
    lazy = false,
    config = function()
      local search_replace = require('search-replace')

      search_replace.setup({
        keymap = false,
        visual = {
          escape_regex = true,
          auto_focus_replace = true,
        },
        realtime = {
          enabled = true,
          min_chars = 2,
          debounce_ms = 300,
        },
      })

      local keymap = vim.keymap
      local opts = { noremap = true, silent = true }

      keymap.set('n', '<leader>S', function()
        search_replace.open()
      end, { desc = 'Open Search-Replace panel', noremap = true, silent = true })

      keymap.set('n', '<leader>sw', function()
        local word = vim.fn.expand('<cword>')
        if word and word ~= '' then
          search_replace.open({ visual_text = word })
        else
          search_replace.open()
        end
      end, { desc = 'Search current word with Search-Replace', noremap = true, silent = true })

      keymap.set('v', '<leader>sw', function()
        search_replace.open_visual()
      end, { desc = 'Search selection with Search-Replace', noremap = true, silent = true })

      keymap.set('n', '<leader>sf', function()
        search_replace.open()
      end, { desc = 'Search in current file with Search-Replace', noremap = true, silent = true })
    end,
  },
  {
    'ej-shafran/compile-mode.nvim',
    branch = 'nightly',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>mm', vim.cmd.Compile, { desc = 'Compile command' })
      vim.keymap.set('n', '<leader>mr', vim.cmd.Recompile, { desc = 'Recompile previous command' })
      vim.keymap.set('n', '<leader>mn', vim.cmd.NextError, { desc = 'Go to next compilation error' })
      vim.keymap.set('n', '<leader>mp', vim.cmd.PrevError, { desc = 'Go to previous compilation error' })
      vim.g.compile_mode = {
        input_word_completion = true,
        use_circular_error_navigation = true,
        focus_compilation_buffer = true,
      }
    end,
  },
  {
    'nativerv/cyrillic.nvim',
    event = { 'VeryLazy' },
    config = function()
      require('cyrillic').setup({
        no_cyrillic_abbrev = false,
      })
    end,
  },
}

return plugins