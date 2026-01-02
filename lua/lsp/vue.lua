---@brief
---
--- Vue Language Server (Volar)
---
--- https://github.com/vuejs/language-tools
---
--- Vue Language Server provides language support for Vue.js single-file components (.vue files).
---
--- Features:
--- - Syntax highlighting for Vue SFC
--- - TypeScript support in `<script>` blocks
--- - Template interpolation and directive support
--- - Component prop validation
--- - Auto-completion for Vue directives and components
---
--- Installation:
--- ```sh
--- npm install -g @vue/language-server
--- ```
---
--- @type vim.lsp.Config
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  init_options = {
    vue = {
      hybridMode = false,
    },
    typescript = {
      tsdk = '', -- Will be auto-detected
    },
  },
  root_dir = function(bufnr, on_dir)
    local root_markers = { 'package.json', 'vue.config.js', 'vite.config.js', 'vite.config.ts', '.git' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    vue = {
      autoInsert = {
        dotValue = true,
      },
      completion = {
        autoImport = true,
        tagCasing = 'kebab',
      },
      updateImportsOnFileMove = {
        enabled = true,
      },
      inlayHints = {
        enabled = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Enable formatting for Vue files (using prettier which is already installed)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    -- Custom keymaps for Vue
    vim.keymap.set('n', '<leader>vu', function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = 'Show Vue component info' })

    vim.keymap.set('n', '<leader>vp', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'Format Vue file' })
  end,
}