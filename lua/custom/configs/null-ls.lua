local null_ls = require('null-ls')

local opts = {
  sources  = {
    -- null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.black.with({
      extra_args = {"--line-length", "79"}
    })
  }
}
return opts
