local plugins = {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')
      local actions = require('telescope.actions')
      local undo_actions = require('telescope-undo.actions')
      local keymap = vim.keymap

      keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Fuzzy find files in cwd' })
      keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Fuzzy find recent files' })
      keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
      keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Find git commits' })
      keymap.set('n', '<leader>gb', builtin.git_bcommits, { desc = 'Find git commits for buffer' })
      keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find keymaps' })
      keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })
      keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Find registers' })
      keymap.set('n', '<leader>fu', telescope.extensions.undo.undo, { desc = 'Find in undo tree' })
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-y>'] = actions.select_default,
            },
            n = {
              ['<C-y>'] = actions.select_default,
            },
          },
        },
        extensions = {
          undo = {
            use_delta = true,
            use_custom_command = nil,
            side_by_side = true,
            vim_diff_opts = { ctxlen = vim.o.scrolloff },
            entry_format = 'state #$ID, $STAT, $TIME',
            mappings = {
              i = {
                ['<cr>'] = undo_actions.yank_additions,
                ['<S-cr>'] = undo_actions.yank_deletions,
                ['<C-cr>'] = undo_actions.restore,
                ['<C-y>'] = undo_actions.yank_deletions,
                ['<C-r>'] = undo_actions.restore,
              },
              n = {
                ['y'] = undo_actions.yank_additions,
                ['Y'] = undo_actions.yank_deletions,
                ['u'] = undo_actions.restore,
              },
            },
          },
        },
      })
      telescope.load_extension('undo')
    end,
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
  },
}

return plugins