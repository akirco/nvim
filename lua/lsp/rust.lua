---@brief
---
--- Rust Analyzer Language Server
---
--- https://rust-analyzer.github.io/
---
--- Rust Analyzer is the official language server for Rust, providing code completion,
--- type information, refactoring, and more for Rust projects.
---
--- Features:
--- - Auto-completion with type information
--- - Go to definition and references
--- - Inline type hints and parameter hints
--- - Code actions for refactoring and fixes
--- - Cargo.toml dependency management
---
--- Installation:
--- Rust Analyzer is typically installed via rustup:
--- ```sh
--- rustup component add rust-analyzer
--- ```
--- Or through package managers.
---
--- @type vim.lsp.Config
return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = function(bufnr, on_dir)
    local root_markers = { 'Cargo.toml', '.git' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
      completion = {
        autoimport = {
          enable = true,
        },
      },
      diagnostics = {
        disabled = {},
        enable = true,
        experimental = {
          enable = true,
        },
      },
      hover = {
        actions = {
          enable = true,
          references = {
            enable = true,
          },
        },
      },
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closingBraceHints = {
          enable = true,
          minLines = 25,
        },
        closureReturnTypeHints = {
          enable = 'always',
        },
        lifetimeElisionHints = {
          enable = 'always',
          useParameterNames = true,
        },
        maxLength = 25,
        parameterHints = {
          enable = true,
        },
        reborrowHints = {
          enable = 'always',
        },
        renderColons = true,
        typeHints = {
          enable = true,
          hideClosureInitialization = false,
          hideNamedConstructor = false,
        },
      },
      lens = {
        enable = true,
        implementations = {
          enable = true,
        },
        run = {
          enable = true,
        },
      },
      notifications = {
        cargoTomlNotFound = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Rust Analyzer provides formatting capabilities
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    -- Custom keymaps for Rust
    vim.keymap.set('n', '<leader>rr', function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = 'Show Rust type info' })

    vim.keymap.set('n', '<leader>rf', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'Format Rust file' })

    vim.keymap.set('n', '<leader>rt', function()
      vim.lsp.buf.code_action({
        context = {
          only = { 'quickfix' },
          diagnostics = vim.diagnostic.get(bufnr),
        },
      })
    end, { buffer = bufnr, desc = 'Rust code actions' })
  end,
}