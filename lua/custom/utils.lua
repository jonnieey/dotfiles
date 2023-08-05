-- function GetDate()
--   local selected_text = vim.fn.getreg("")
--   local formatted_date = nil
--   local command = string.format("date --date='%s' '+%%Y-%%m-%%d'", selected_text)
--   local handle = io.popen(command)
--   formatted_date = handle:read("*a")
--   handle.close()
--   formatted_date = formatted_date:gsub("\n", "")
--   if formatted_date ~= "" then
--     vim.api.nvim_command(
--       's,\v' .. selected_text .. ',' .. formatted_date )
--   end
--
-- end
function BufText()
	local bufnr = vim.api.nvim_win_get_buf(0)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, vim.api.nvim_buf_line_count(bufnr), true)
	local text = ""
	for _, line in ipairs(lines) do
		text = text .. line .. "\n"
	end
	return text
end

function ReplaceBufLines(bufnr, lines)
	return vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

function BufVtext()
	local a_orig = vim.fn.getreg("a")
	local mode = vim.fn.mode()
	if mode ~= "v" and mode ~= "V" then
		vim.cmd([[normal! gv]])
	end
	vim.cmd([[silent! normal! "aygv]])
	local text = vim.fn.getreg("a")
	vim.fn.setreg("a", a_orig)
	return text
end

function BufVtextOrText()
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" then
		return BufVtext()
	end
	return BufText()
end
function GetDate()
	local selected_text = BufVtextOrText()
	local command = string.format("date --date='%s' '+%%Y-%%m-%%d'", selected_text)
	local formatted_date = io.popen(command):read("*a"):gsub("\n", "")
	local start = vim.fn.getpos("'<")
	local s_buf, s_row, s_col = start[1], start[2], start[3]
	local fin = vim.fn.getpos("'>")
	local e_row, e_col = fin[2], fin[3]
	vim.api.nvim_buf_set_text(s_buf, e_row - 1, s_col - 1, e_row - 1, e_col, {})
	vim.api.nvim_buf_set_text(s_buf, s_row - 1, s_col - 1, e_row - 1, s_col - 1, { formatted_date })
end

return {
	buf_text = BufText,
	buf_vtext = BufVtext,
	get_date = GetDate,
}
