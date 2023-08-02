local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "pylsp",
        "ruff",
        "mypy",
        "debugpy",
        "black",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = true,
    ft = {"python"},
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings("dap")
      require('dap.ext.vscode').load_launchjs(nil, { python = {'python'} })
    end
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependancies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require('dap-python').setup(path)
      require("core.utils").load_mappings("dap_python")
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependancies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  { "tpope/vim-fugitive", lazy = false},

  {
    "yegappan/taglist",
    lazy = false,
    config = function()
      vim.g.Tlist_Auto_Highlight_Tag = 1
      vim.g.Tlist_Auto_Open = 0
      vim.g.Tlist_Auto_Update = 1
      vim.g.Tlist_Compact_Format = 1
      vim.g.Tlist_Display_Tag_Scope = 1
      vim.g.Tlist_Enable_Fold_Column = 1
      vim.g.Tlist_File_Fold_Auto_Close = 1
      vim.g.Tlist_GainFocus_On_ToggleOpen = 1
      vim.g.Tlist_Inc_Winwidth = 1
      vim.g.Tlist_Show_One_File = 1
      vim.g.Tlist_Sort_Type = "order"
      vim.g.Tlist_Use_Right_Window = 1
      vim.g.Tlist_WinWidth = 40
      vim.api.nvim_set_keymap('n', '<leader>t', [[:TlistToggle<CR>]], {noremap=true, silent=true})
    end,

  },
  { 'Exafunction/codeium.vim', },
}
return plugins
