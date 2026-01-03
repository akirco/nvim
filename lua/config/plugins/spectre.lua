return {
  'Jason-Bai/search-replace.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
  },
  lazy = false,  -- Load on startup to register keymaps
  config = function()
    local search_replace = require('search-replace')

    search_replace.setup({
      keymap = false,  -- Disable default <leader>sr mapping
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

    -- 设置键位映射
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- 打开/关闭 search-replace 面板 (替代原来的 <leader>S)
    keymap.set('n', '<leader>S', function()
      search_replace.open()
    end, { desc = 'Open Search-Replace panel', noremap = true, silent = true })

    -- 在当前单词上打开 search-replace (替代原来的 <leader>sw normal)
    keymap.set('n', '<leader>sw', function()
      local word = vim.fn.expand('<cword>')
      if word and word ~= '' then
        -- Open with current word as search text
        search_replace.open({ visual_text = word })
      else
        search_replace.open()
      end
    end, { desc = 'Search current word with Search-Replace', noremap = true, silent = true })

    -- 在视觉选择上打开 search-replace (替代原来的 <leader>sw visual)
    keymap.set('v', '<leader>sw', function()
      search_replace.open_visual()
    end, { desc = 'Search selection with Search-Replace', noremap = true, silent = true })

    -- 在当前文件内搜索 (替代原来的 <leader>sf)
    keymap.set('n', '<leader>sf', function()
      -- Open search-replace and maybe filter to current file?
      search_replace.open()
      -- Note: User can manually add file filter after opening
    end, { desc = 'Search in current file with Search-Replace', noremap = true, silent = true })
  end,
}