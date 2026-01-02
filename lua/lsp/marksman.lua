---@brief
---
--- Marksman Language Server
---
--- https://github.com/artempyanykh/marksman
---
--- Marksman is a language server for Markdown that provides completion, diagnostics,
--- cross-references, and more for Markdown documents.
---
--- Features:
--- - Auto-completion for links, references, and headings
--- - Go to definition for links and references
--- - Find references for headings and link definitions
--- - Diagnostics for broken links and reference issues
--- - Support for math, frontmatter, and wikilinks
---
--- Installation:
--- Download from GitHub releases or install via package managers.
---
--- @type vim.lsp.Config
return {
  cmd = { 'marksman', 'server' },
  filetypes = { 'markdown', 'markdown.mdx' },
  root_dir = function(bufnr, on_dir)
    local root_markers = { '.git', '.marksman.toml', 'README.md', 'package.json' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    marksman = {
      enable = true,
      links = {
        enable = true,
      },
      completion = {
        enable = true,
      },
      diagnostics = {
        enable = true,
      },
      math = {
        enable = true,
      },
      references = {
        enable = true,
      },
      frontmatter = {
        enable = true,
      },
      wikilinks = {
        enable = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Marksman provides formatting for markdown
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    -- Custom keymaps for Markdown
    vim.keymap.set('n', '<leader>md', function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = 'Show Markdown link info' })

    vim.keymap.set('n', '<leader>mf', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'Format Markdown file' })

    vim.keymap.set('n', '<leader>ml', function()
      vim.lsp.buf.code_action({
        context = {
          only = { 'quickfix' },
          diagnostics = vim.diagnostic.get(bufnr),
        },
      })
    end, { buffer = bufnr, desc = 'Markdown link actions' })
  end,
}