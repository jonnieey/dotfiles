local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

lspconfig.pylsp.setup({
	pylsp = {
		plugins = {
			black = {
				enabled = true,
				line_length = 79,
				cache_config = false,
				preview = false,
				skip_string_normalization = false,
				skip_magic_trailing_comma = false,
			},
      mypy = {
        enabled = true,
        live_mode = false,
        dmypy = true,
        strict = false,
      }
		},
	},
})
