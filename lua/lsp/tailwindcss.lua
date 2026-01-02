---@brief
---
--- Tailwind CSS Language Server
---
--- https://github.com/tailwindlabs/tailwindcss-intellisense
---
--- Tailwind CSS Language Server provides autocompletion, syntax highlighting, and linting for Tailwind CSS classes.
---
--- Features:
--- - Autocomplete for Tailwind CSS classes
--- - Syntax highlighting for Tailwind CSS classes
--- - Linting for invalid or missing Tailwind CSS classes
--- - Support for custom CSS and variants
---
--- Configuration:
--- The language server reads configuration from `tailwind.config.js` or `tailwind.config.cjs` files.
---
--- Installation:
--- ```sh
--- npm install -g @tailwindcss/language-server
--- ```
---
--- @type vim.lsp.Config
return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'html',
    'css',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
    'php',
    'blade',
    'twig',
    'markdown',
    'mdx',
    'handlebars',
    'hbs',
  },
  init_options = {
    userLanguages = {
      html = 'html',
      css = 'css',
      javascript = 'javascript',
      javascriptreact = 'javascriptreact',
      typescript = 'typescript',
      typescriptreact = 'typescriptreact',
      vue = 'vue',
      svelte = 'svelte',
      astro = 'astro',
      php = 'php',
      blade = 'blade',
      twig = 'twig',
      markdown = 'markdown',
      mdx = 'mdx',
      handlebars = 'handlebars',
      hbs = 'hbs',
    },
  },
  root_dir = function(bufnr, on_dir)
    local root_markers = { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'tailwind.config.mjs', 'package.json', '.git' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    tailwindCSS = {
      emmetCompletions = true,
      includeLanguages = {
        html = 'html',
        css = 'css',
        javascript = 'javascript',
        javascriptreact = 'javascriptreact',
        typescript = 'typescript',
        typescriptreact = 'typescriptreact',
        vue = 'vue',
        svelte = 'svelte',
        astro = 'astro',
        php = 'php',
        blade = 'blade',
        twig = 'twig',
        markdown = 'markdown',
        mdx = 'mdx',
        handlebars = 'handlebars',
        hbs = 'hbs',
      },
      experimental = {
        classRegex = {
          'cva\\(([^)]*)\\)',
          'cn\\(([^)]*)\\)',
          'tw\\(([^)]*)\\)',
        },
      },
      validate = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Optional: Add custom keymaps or commands for Tailwind CSS
    -- Example: Show CSS for selected Tailwind class
    vim.keymap.set('n', '<leader>tw', function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = 'Show Tailwind CSS class details' })
  end,
}