local null_ls = require("null-ls")

local opts = {
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.djlint,
	},
}
return opts
