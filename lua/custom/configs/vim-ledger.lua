local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

vim.foldmethod = "syntax"
vim.noexpandtab = true
g.ledger_align_at = 60
g.ledger_align_commodity = 1
g.ledger_bin = "/usr/bin/ledger"
g.ledger_cleared_string = "Cleared: "
g.ledger_commodity_before = 1
g.ledger_commodity_sep = ""
g.ledger_commodity_spell = 1
g.ledger_date_format = "%Y/%m/%d"
g.ledger_decimal_sep = "."
g.ledger_default_commodity = ""
g.ledger_detailed_first = 1
g.ledger_extra_options = "--pedantic --explicit"
g.ledger_fillstring = "-"
g.ledger_fold_blanks = 1
g.ledger_is_hledger = 0
g.ledger_main = "%"
g.ledger_maxwidth = 75
g.ledger_pending_string = "Cleared or pending: "
g.ledger_qf_hide_file = 1
g.ledger_qf_reconcile_format = "%(date) %-4(code) %-50(payee) %-30(account) %15(amount)\n"
g.ledger_qf_register_format = "%(date) %-50(payee) %-30(account) %15(amount) %15(total)\n"
g.ledger_qf_size = 10
g.ledger_qf_vertical = 0
g.ledger_target_string = "Difference from target: "
g.ledger_use_location_list = 0
g.ledger_winpos = "B"

autocmd("FileType", {
	pattern = "ledger",
	callback = function()
		vim.api.nvim_set_keymap("n", "{", [[?^\d<cr>]], { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "}", [[/^\d<cr>]], { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"v",
			"<leader>al",
			[[:%EasyAlign /\-\?[(0-9]\+\.[0-9]\+ [A-Z]\{3\}/ {'lm': 5}<CR>]],
			{ silent = true }
		)
		vim.keymap.set("v", "<leader>gd", function()
			require("custom.utils").get_date()
			vim.cmd("normal $")
		end, { noremap = true, silent = true })
	end,
})
