---@brief
---
--- INI Language Server
---
--- Provides language support for INI configuration files.
---
--- Features:
--- - Syntax highlighting and validation
--- - Basic completion for sections and keys
--- - Diagnostics for syntax errors
---
--- Installation:
--- ```sh
--- npm install -g ini-language-server
--- ```
---
--- @type vim.lsp.Config
return {
  cmd = { 'ini-language-server', '--stdio' },
  filetypes = { 'ini', 'conf', 'properties' },
  root_dir = function(bufnr, on_dir)
    local root_markers = { '.git', 'package.json' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  on_attach = function(client, bufnr)
    -- INI language server may provide formatting
    if client.server_capabilities.documentFormattingProvider then
      client.server_capabilities.documentFormattingProvider = true
    end
  end,
}