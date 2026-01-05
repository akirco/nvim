require('core')

require('plugins')

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    -- Apply colorscheme after all plugins are loaded
    vim.schedule(function()
      require('config.colorscheme').setup()
    end)
    -- Load LSP configuration
    require('lsp')
  end,
  once = true,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('lsp')
  end,
  once = true,
})