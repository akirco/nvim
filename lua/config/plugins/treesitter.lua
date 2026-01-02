return {
  'nvim-treesitter/nvim-treesitter',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  branch = 'master',
  lazy = false,
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    local treesitter = require('nvim-treesitter.configs')

    treesitter.setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function()
          return vim.b.large_buf
        end,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      ensure_installed = {
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'bash',
        'dockerfile',
        'gitignore',
        'go',
        'python',
        'toml',
        'sql',
        'comment',
        'gomod',
        'gowork',
        'gosum',
        'asm',
        -- Add support for requested languages
        -- 'tailwindcss', -- Parser not available, removed to prevent installation error
        'vue',
        'rust',
        'markdown',
        'markdown_inline',
        'zig',
        'ini',
      },
      rainbow = {
        enable = true,
        disable = { 'html' },
        extended_mode = false,
        max_file_lines = nil,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
    })
  end,
}
