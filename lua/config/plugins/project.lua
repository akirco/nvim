return {
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/Projects/aigen/*",
        "~/Projects/android/*",
        "~/Projects/bun/*",
        "~/Projects/deno/*",
        "~/Projects/electron/*",
        "~/Projects/flutter/*",
        "~/Projects/golang/*",
        "~/Projects/lua/*",
        "~/Projects/markdown/*",
        "~/Projects/miniapp/*",
        "~/Projects/nextjs/*",
        "~/Projects/nodejs/*",
        "~/Projects/openplan/*",
        "~/Projects/powershell/*",
        "~/Projects/python/*",
        "~/Projects/reactjs/*",
        "~/Projects/repository/*",
        "~/Projects/rust/*",
        "~/Projects/shell/*",
        "~/Projects/tauri/*",
        "~/Projects/temp/*",
        "~/Projects/tui/*",
        "~/Projects/vuejs/*",
        "~/Projects/webapi/*",
        "~/Projects/workspaces/*",
        "~/Projects/zig/*"
      },
      picker = {
        type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"
      }
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      -- optional picker (telescope already exists in config)
      { "nvim-telescope/telescope.nvim" },
      -- optional picker
      -- { "ibhagwan/fzf-lua" },
      -- optional picker
      -- { "folke/snacks.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
    config = function(_, opts)
      require("neovim-project").setup(opts)
      -- Set keymaps for project management
      local keymap = vim.keymap
      local project = require("neovim-project.project")
      keymap.set("n", "<leader>pp", function()
        project.show_history()
      end, { desc = "Open project history" })
      keymap.set("n", "<leader>pl", function()
        project.discover_projects()
      end, { desc = "Discover projects" })
    end,
  }
}