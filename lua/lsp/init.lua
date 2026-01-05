vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }
    if vim.b.large_buf then
      vim.schedule(function()
        vim.notify('LSP disabled for large files', vim.log.levels.WARN)
      end)
      ---@diagnostic disable-next-line:param-type-mismatch
      vim.lsp.get_client_by_id(event.data.client_id).stop(true)
      return
    end

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

local function setup_lsp_capabilities()
  if pcall(require, 'blink.cmp') then
    local capabilities = require('blink.cmp').get_lsp_capabilities()
    vim.lsp.setup('*', {
      capabilities = capabilities,
      root_markers = { '.git' },
    })
  end
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyLoad',
  callback = function(data)
    if data.data and data.data.name == 'blink.cmp' then
      setup_lsp_capabilities()
    end
  end,
})

vim.diagnostic.config({
  virtual_lines = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
    },
  },
})