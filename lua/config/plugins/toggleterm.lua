return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = 'VeryLazy',
  config = function()
    local toggleterm = require('toggleterm')

    toggleterm.setup({
      -- 终端大小配置
      size = function(term)
        if term.direction == 'horizontal' then
          return 15  -- 底部面板高度
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4  -- 侧边面板宽度
        end
      end,
      -- 打开终端的方向
      direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
      -- 从哪个窗口打开终端
      start_in_insert = true,
      -- 插入模式快捷键
      insert_mappings = true,
      -- 终端窗口设置
      persist_size = true,
      persist_mode = true,
      -- 浮动窗口配置
      float_opts = {
        border = 'rounded',
        width = function() return math.floor(vim.o.columns * 0.8) end,
        height = function() return math.floor(vim.o.lines * 0.8) end,
        winblend = 3,
      },
      -- 高亮配置
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
      -- 自动切换到终端窗口
      auto_scroll = true,
      -- 终端窗口关闭行为
      close_on_exit = true,
      -- 终端缓冲区自动隐藏
      hide_numbers = true,
      -- 终端标签页
      shade_terminals = true,
      shading_factor = 2,
    })

    -- 设置键位映射
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- 切换主终端（类似VSCode的Ctrl+`）
    keymap.set('n', '<C-`>', function()
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new({ direction = 'horizontal' })
      term:toggle()
    end, { desc = 'Toggle terminal panel (VSCode style)' })

    -- 在浮动窗口中打开终端
    keymap.set('n', '<leader>tf', function()
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new({ direction = 'float' })
      term:toggle()
    end, { desc = 'Toggle floating terminal' })

    -- 在垂直分割中打开终端
    keymap.set('n', '<leader>tv', function()
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new({ direction = 'vertical' })
      term:toggle()
    end, { desc = 'Toggle vertical terminal' })

    -- 打开多个终端
    keymap.set('n', '<leader>t2', function()
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new({ direction = 'horizontal' })
      term:toggle()
      local term2 = Terminal:new({ direction = 'horizontal' })
      term2:toggle()
    end, { desc = 'Open two terminal panels' })

    -- 终端模式下的快捷键
    keymap.set('t', '<C-`>', '<Cmd>ToggleTerm<CR>', opts)
    keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
    keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  end,
}