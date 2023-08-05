local plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"python-lsp-server",
				"prettier",
				"mypy",
				"debugpy",
				"black",
				"stylua",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		lazy = true,
		ft = { "python", "lua" },
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},

	{
		"mfussenegger/nvim-dap",
		config = function(_, opts)
			require("core.utils").load_mappings("dap")
			require("dap.ext.vscode").load_launchjs(nil, { python = { "python" } })
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
			require("core.utils").load_mappings("dap_python")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		lazy = false,
		dependencies = "mfussenegger/nvim-dap",
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
	{ "tpope/vim-fugitive", lazy = false },

	{
		"yegappan/taglist",
		lazy = false,
		config = function(_, opts)
			require("custom.configs.taglist")
		end,
	},
	{ "Exafunction/codeium.vim" },
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({})
		end,
	},
	{
		"ledger/vim-ledger",
		lazy = false,
    config = function()
      require("custom.configs.vim-ledger")
    end,
	},
}
return plugins
