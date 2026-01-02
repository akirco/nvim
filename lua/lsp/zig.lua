---@brief
---
--- Zig Language Server (ZLS)
---
--- https://github.com/zigtools/zls
---
--- Zig Language Server provides language support for Zig, including completion,
--- go-to-definition, hover documentation, and more.
---
--- Features:
--- - Auto-completion with type information
--- - Go to definition and references
--- - Hover documentation for functions and types
--- - Build system integration
--- - Semantic highlighting
---
--- Installation:
--- Follow instructions at https://github.com/zigtools/zls#installation
---
--- @type vim.lsp.Config
return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_dir = function(bufnr, on_dir)
    local root_markers = { 'build.zig', 'build.zig.zon', '.git', 'zls.json' }
    local project_root = vim.fs.root(bufnr, root_markers)
    on_dir(project_root or vim.fn.getcwd())
  end,
  settings = {
    zls = {
      enable = true,
      warn_style = true,
      enable_snippets = true,
      enable_autofix = false,
      enable_ast_check_diagnostics = true,
      enable_import_embedfile = true,
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = false,
      inlay_hints_hide_redundant_param_names_last_token = false,
      operator_completions = true,
      include_at_in_builtins = false,
      max_detail_length = 256,
      skip_std_references = false,
      enable_semantic_tokens = true,
      enable_references = true,
      enable_definition = true,
      enable_hover = true,
      enable_completion = true,
      enable_signature_help = true,
      enable_rename = true,
      enable_go_to_declaration = true,
      enable_go_to_implementation = true,
      enable_document_symbols = true,
      enable_workspace_symbols = true,
      enable_document_highlight = true,
      enable_document_formatting = true,
      enable_range_formatting = true,
      enable_code_actions = true,
      enable_execute_command = true,
      enable_configuration = true,
      enable_progress = true,
      enable_notifications = true,
      enable_debug = false,
    },
  },
  on_attach = function(client, bufnr)
    -- ZLS provides formatting capabilities
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    -- Custom keymaps for Zig
    vim.keymap.set('n', '<leader>zz', function()
      vim.lsp.buf.hover()
    end, { buffer = bufnr, desc = 'Show Zig type info' })

    vim.keymap.set('n', '<leader>zf', function()
      vim.lsp.buf.format({ async = true })
    end, { buffer = bufnr, desc = 'Format Zig file' })

    vim.keymap.set('n', '<leader>zb', function()
      -- Build Zig project
      vim.cmd('!zig build')
    end, { buffer = bufnr, desc = 'Build Zig project' })
  end,
}