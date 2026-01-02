---@brief
---
--- Bash Language Server
---
--- https://github.com/bash-lsp/bash-language-server
---
--- Bash Language Server provides language support for Bash/Shell scripts.
---
--- Features:
--- - Auto-completion for shell commands and arguments
--- - Go to definition for functions and variables
--- - Hover documentation for shell builtins and commands
--- - Diagnostics and linting integration with shellcheck
---
--- Installation:
--- ```sh
--- npm install -g bash-language-server
--- ```
---
--- @type vim.lsp.Config
return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash' },
  root_dir = function(bufnr, on_dir)
    local root_markers = { '.git', 'package.json', 'Makefile', 'configure', 'autogen.sh' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    bashIde = {
      backgroundAnalysisMaxFiles = 500,
      enableSourceErrorDiagnostics = true,
      explainShellPath = 'explainshell',
      globPattern = '**/*.{sh,bash,zsh,ksh}',
      includeAllWorkspaceSymbols = false,
      logLevel = 'info',
      shellcheckPath = 'shellcheck',
      shellcheckArguments = '',
    },
  },
  on_attach = function(client, bufnr)
    -- Bash language server doesn't provide formatting by default
    -- Use shfmt (already installed via mason) for formatting

    -- Custom keymaps for shell scripts
    vim.keymap.set('n', '<leader>sh', function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = 'Show shell command info' })

    vim.keymap.set('n', '<leader>sf', function()
      -- Use shfmt for formatting shell scripts
      vim.cmd('!shfmt -w %')
      vim.cmd('e!')
    end, { buffer = bufnr, desc = 'Format shell script with shfmt' })
  end,
}