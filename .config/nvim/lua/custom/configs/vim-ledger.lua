local autocmd = vim.api.nvim_create_autocmd
local g = vim.g

g.ledger_align_at = 60
g.ledger_align_commodity = 1
g.ledger_bin = '/usr/bin/ledger'
g.ledger_cleared_string = 'Cleared: '
g.ledger_commodity_before = 1
g.ledger_commodity_sep = ''
g.ledger_commodity_spell = 1
g.ledger_date_format = '%Y-%m-%d'
g.ledger_decimal_sep = '.'
g.ledger_default_commodity = ''
g.ledger_detailed_first = 1
g.ledger_extra_options = '--pedantic --explicit'
g.ledger_fillstring = '-'
g.ledger_fold_blanks = 1
g.ledger_is_hledger = 0
g.ledger_main = '%'
g.ledger_maxwidth = 75
g.ledger_pending_string = 'Cleared or pending: '
g.ledger_qf_hide_file = 1
g.ledger_qf_reconcile_format = '%(date) %-4(code) %-50(payee) %-30(account) %15(amount)\n'
g.ledger_qf_register_format = '%(date) %-50(payee) %-30(account) %15(amount) %15(total)\n'
g.ledger_qf_size = 10
g.ledger_qf_vertical = 0
g.ledger_target_string = 'Difference from target: '
g.ledger_use_location_list = 0
g.ledger_winpos = 'B'

local function get_last_date()
  local last_date
  -- Save the current cursor position
  local current_pos = vim.fn.getpos '.'
  -- Search backward for a line that matches the date pattern
  if vim.fn.search([[\v^\d{4}-\d{2}-\d{2}]], 'bW') then
    local line = vim.fn.getline '.'
    last_date = string.match(line, '(%d%d%d%d%-%d%d%-%d%d)')
  end
  -- Restore the cursor position
  vim.fn.setpos('.', current_pos)
  return last_date
end

-- Function to calculate the next day
local function get_next_day(date, offset)
  local year, month, day = date:match '(%d%d%d%d)%-(%d%d)%-(%d%d)'
  local current_date = { year = tonumber(year), month = tonumber(month), day = tonumber(day) }
  current_date.day = current_date.day + offset
  return os.date('%Y-%m-%d', os.time(current_date))
end

-- Function to insert the next day's ledger entry
local function insert_next_day_entry(offset)
  local last_date = get_last_date()
  if last_date then
    local next_date = get_next_day(last_date, offset)
    local entry = { next_date .. ' *', '  Assets:Checking:Mpesa' }
    vim.api.nvim_put(entry, 'l', true, true)
  else
    print 'No date found in the ledger file.'
  end
end

local function insert_today(offset)
  local last_date = os.date '%Y-%m-%d'
  if last_date then
    local next_date = get_next_day(last_date, offset)
    local entry = { next_date .. ' *', '  Assets:Checking:Mpesa' }
    vim.api.nvim_put(entry, 'l', true, true)
  else
    print 'No date found in the ledger file.'
  end
end

autocmd('FileType', {
  pattern = 'ledger',
  callback = function()
    vim.cmd ':set foldmethod=marker'
    vim.cmd ':set noexpandtab'
    vim.cmd ':Lazy load vim-easy-align'

    vim.api.nvim_set_keymap('n', '{', [[?^\d<cr>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '}', [[/^\d<cr>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>al', [[:%EasyAlign /\-\?[(0-9]\+\.[0-9]\+ [A-Z]\{3\}/ {'lm': 5}<CR>]], { silent = true })
    vim.api.nvim_set_keymap('v', '<leader>al', [[:%EasyAlign /\-\?[(0-9]\+\.[0-9]\+ [A-Z]\{3\}/ {'lm': 5}<CR>]], { silent = true })

    local function create_count_based_command(command_name, insert_function, default_value, negate)
      vim.api.nvim_create_user_command(command_name, function()
        local count = vim.v.count
        if negate then
          count = -count
        end
        if count == 0 then
          insert_function(default_value)
        else
          insert_function(count)
        end
      end, {})
    end

    create_count_based_command('InsertNextDayEntry', insert_next_day_entry, 1, false)
    create_count_based_command('InsertPrevDayEntry', insert_next_day_entry, -1, true)
    create_count_based_command('InsertToday', insert_today, 0, false)
    create_count_based_command('InsertYesterday', insert_today, 0, true)

    -- Bind the function to a key combination (e.g., <leader>le for ledger entry)
    vim.keymap.set('n', '<leader>ln', '<cmd>InsertNextDayEntry<cr>O', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>lN', '<cmd>InsertPrevDayEntry<cr>O', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>lt', '<cmd>InsertToday<cr>O', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>lT', '<cmd>InsertYesterday<cr>O', { noremap = true, silent = true })
  end,
})
autocmd('BufWritePost', {
  pattern = '*.ledger',
  callback = function()
    -- remove 2 or more empty lines
    vim.cmd [[:silent g/^\n\n/d]]
    vim.cmd [[:silent %s/\t/  /e]]
  end,
})
