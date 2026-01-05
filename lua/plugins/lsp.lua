local plugins = {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    enabled = true,
    dependencies = {
      { 'mason-org/mason.nvim' },
    },
    config = function()
      require('mason').setup()
      local mason_tool_installer = require('mason-tool-installer')

      mason_tool_installer.setup({
        ensure_installed = {
          'shellcheck',
          'prettier',
          'stylua',
          'shfmt',
          'checkmake',
          'ruff',
          'golines',
          'gofumpt',
          'lua-language-server',
          'gopls',
          'clangd',
          'yaml-language-server',
          'taplo',
          'clang-format',
          'basedpyright',
          'typescript-language-server',
          'asm-lsp',
          'ast-grep',
          'tailwindcss-language-server',
          'vue-language-server',
          'rust-analyzer',
          'bash-language-server',
          'marksman',
          'zls',
          'deno',
          'eslint_d',
          'golangci-lint',
          'stylelint',
          'vscode-css-language-server',
          'vscode-eslint-language-server',
          'vscode-html-language-server',
          'vscode-json-language-server',
          'yamlfmt',
          'nimlangserver',
          'jq-lsp',
          'svelteserver',
          'wc-language-server',
          'pyright',
          'codebook-lsp',
          'codelldb',
          'debugpy',
          'dlv',
          'js-debug-adapter',
        },
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 5,
        integrations = {
          ['mason-lspconfig'] = true,
          ['mason-null-ls'] = false,
          ['mason-nvim-dap'] = true,
        },
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason.nvim',
      'nvim-lspconfig',
    },
    config = function()
      local mason_lspconfig = require('mason-lspconfig')
      local lspconfig = require('lspconfig')

      local common_config = {
        capabilities = require('blink.cmp').get_lsp_capabilities()
      }

      _G.common_lsp_config = common_config

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

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }
          if vim.b.large_buf then
            vim.schedule(function()
              vim.notify('LSP disabled for large files', vim.log.levels.WARN)
            end)
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
          vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    enabled = true,
    config = function()
      local conform = require('conform')

      conform.setup({
        formatters_by_ft = {
          ['*'] = { 'trim_whitespace' },
          python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          lua = { 'stylua' },
          sh = { 'shfmt' },
          html = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier' },
          markdown = { 'prettier' },
          go = { 'gofumpt', 'golines' },
          toml = { 'tombi' },
          c = { 'clang-format' },
          cpp = { 'clang-format' },
          rust = { 'lsp' },
          zig = { 'lsp' },
          ini = { 'lsp' },
        },
        formatters = {
          shfmt = {
            prepend_args = { '-i', '4' },
          },
          ruff_format = {
            prepend_args = {
              '--config',
              'format.quote-style="single"',
              '--config',
              'format.skip-magic-trailing-comma=false',
              '--config',
              'format.line-ending="auto"',
              '--config',
              'line-length=120',
            },
          },
          prettier = {
            options = {
              ft_parsers = {
                javascript = 'babel',
                javascriptreact = 'babel',
                typescript = 'typescript',
                typescriptreact = 'typescript',
                vue = 'vue',
                css = 'css',
                scss = 'scss',
                less = 'less',
                html = 'html',
                json = 'json',
                jsonc = 'json',
                markdown = 'markdown',
                ['markdown.mdx'] = 'mdx',
                graphql = 'graphql',
                handlebars = 'glimmer',
                yaml = 'yaml',
              },
            },
          },
          golines = {
            command = 'golines',
            args = {
              '--max-len=150',
            },
            stdin = true,
          },
        },
        format_on_save = function(bufnr)
          if vim.b.large_buf then
            vim.schedule(function()
              vim.notify('Formatting disabled for large files', vim.log.levels.WARN)
            end)
            return
          end
          return { timeout_ms = 1000, lsp_format = 'fallback', async = false, quiet = false }
        end,
        format_after_save = function(bufnr)
          if vim.b.large_buf then
            return
          end
          return { lsp_format = 'fallback' }
        end,
      })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    enabled = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        python = { 'ruff' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
        makefile = { 'checkmake' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
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
      })
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    version = '1.*',
    config = function()
      require('blink.cmp').setup({
        cmdline = {
          enabled = true,
          keymap = {
            ['<Tab>'] = { 'show', 'accept' },
          },
        },
        completion = {
          documentation = {
            auto_show = true,
            treesitter_highlighting = true,
            window = {
              border = 'rounded',
            },
          },
          keyword = {
            range = 'prefix',
          },
          list = {
            selection = {
              preselect = true,
              auto_insert = false,
            },
          },
          accept = {
            dot_repeat = true,
            create_undo_point = true,
            auto_brackets = {
              enabled = true,
            },
          },
          menu = {
            border = 'rounded',
            draw = {
              columns = { { 'kind_icon' }, { 'label', 'label_detail', gap = 1 }, { 'kind' } },
              components = {
                label = {
                  width = { max = 30, fill = true },
                  text = function(ctx)
                    return ctx.label
                  end,
                },
                label_detail = {
                  width = { fill = true, max = 15 },
                  text = function(ctx)
                    return ctx.label_detail
                  end,
                },
                source_name = {},
                kind_icon = {
                  text = function(ctx)
                    local icon = require('neokinds').config.completion_kinds[ctx.kind] or ''
                    return icon
                  end,
                  highlight = function(ctx)
                    return 'CmpItemKind' .. (ctx.kind or 'Default')
                  end,
                },
              },
            },
          },
        },
        keymap = {
          ['<CR>'] = { 'accept', 'fallback' },
          ['<Tab>'] = { 'snippet_forward', 'fallback' },
          ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
          },
        appearance = {
          nerd_font_variant = 'mono',
        },
        signature = { enabled = true, window = { border = 'single' } },

        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
          providers = {
            buffer = {
              enabled = true,
              opts = {
                get_bufnrs = function()
                  return vim.tbl_filter(function(bufnr)
                    return vim.bo[bufnr].buftype == ''
                  end, vim.api.nvim_list_bufs())
                end,
              },
            },
            snippets = {
              enabled = true,
            },
          },
        },
        fuzzy = {
          implementation = 'rust',
          frecency = {
            enabled = false,
          },
          use_proximity = false,
          max_typos = function(_)
            return 0
          end,
          prebuilt_binaries = {
            download = true,
            ignore_version_mismatch = true,
          },
        },
      })

    end,
  },
}

return plugins
