return {
  'nvim-pack/nvim-spectre',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    local spectre = require('spectre')

    spectre.setup({
      mapping = {
        ['toggle_line'] = {
          map = 'dd',
          cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
          desc = "toggle current item",
        },
        ['enter_file'] = {
          map = '<cr>',
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = "goto current file",
        },
        ['send_to_qf'] = {
          map = '<leader>q',
          cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
          desc = "send all items to quickfix",
        },
        ['replace_cmd'] = {
          map = '<leader>c',
          cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
          desc = "input replace command",
        },
        ['show_option_menu'] = {
          map = '<leader>o',
          cmd = "<cmd>lua require('spectre').show_options()<CR>",
          desc = "show option",
        },
        ['run_replace'] = {
          map = '<leader>R',
          cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
          desc = "replace all",
        },
        ['change_view_mode'] = {
          map = '<leader>v',
          cmd = "<cmd>lua require('spectre').change_view()<CR>",
          desc = "change result view mode",
        },
        ['toggle_ignore_case'] = {
          map = 'I',
          cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
          desc = "toggle ignore case",
        },
        ['toggle_ignore_hidden'] = {
          map = 'H',
          cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
          desc = "toggle search hidden",
        },
      },
      find_engine = {
        ['rg'] = {
          cmd = 'rg',
          args = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
          },
          options = {
            ['ignore-case'] = {
              value = '--ignore-case',
              icon = '[I]',
              desc = 'ignore case',
            },
            ['hidden'] = {
              value = '--hidden',
              desc = 'hidden file',
              icon = '[H]',
            },
          },
        },
      },
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = nil,
          options = {
            ['ignore-case'] = {
              value = '--ignore-case',
              icon = '[I]',
              desc = 'ignore case',
            },
          },
        },
      },
      default = {
        find = {
          cmd = 'rg',
          options = { 'ignore-case' },
        },
        replace = {
          cmd = 'sed',
        },
      },
      replace_vim_cmd = 'cdo',
      is_open_target_win = true,
      is_insert_mode = false,
    })

    -- 设置键位映射
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- 打开/关闭 spectre 面板
    keymap.set('n', '<leader>S', function()
      spectre.open()
    end, { desc = 'Open Spectre (search & replace)', noremap = true, silent = true })

    -- 在当前单词上打开 spectre
    keymap.set('n', '<leader>sw', function()
      spectre.open_visual({ select_word = true })
    end, { desc = 'Search current word with Spectre', noremap = true, silent = true })

    -- 在视觉选择上打开 spectre
    keymap.set('v', '<leader>sw', function()
      spectre.open_visual()
    end, { desc = 'Search selection with Spectre', noremap = true, silent = true })

    -- 在当前文件内搜索
    keymap.set('n', '<leader>sf', function()
      spectre.open_file_search()
    end, { desc = 'Search in current file with Spectre', noremap = true, silent = true })
  end,
}