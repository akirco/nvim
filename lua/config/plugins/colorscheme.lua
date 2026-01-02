return {
  {
    'shadowy-pycoder/arctic.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    name = 'arctic',
    branch = 'v2',
    priority = 1000,
    config = function()
      -- Theme will be set by config.colorscheme
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        contrast = 'hard',
        transparent_mode = false,
      })
    end,
  },
  {
    'Ferouk/bearded-nvim',
    name = 'bearded',
    priority = 1000,
    build = function()
      -- Generate helptags so :h bearded-theme works
      local doc = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy', 'bearded', 'doc')
      pcall(vim.cmd, 'helptags ' .. doc)
    end,
    config = function()
      require('bearded').setup({
        flavor = 'arc', -- any flavor slug
      })
      -- Theme will be set by config.colorscheme
    end,
  },
}

