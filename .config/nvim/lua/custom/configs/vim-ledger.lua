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
g.ledger_fold_blanks = 0
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
    local entry = { next_date .. ' *', '    Assets:Checking:Mpesa' }
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
  pattern = { 'ledger', 'beancount', 'bean' },
  callback = function()
    vim.cmd 'setlocal nowrap'
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
    vim.keymap.set('n', '<leader>ln', '<cmd>InsertNextDayEntry<cr>o', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>lN', '<cmd>InsertPrevDayEntry<cr>o', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>lt', '<cmd>InsertToday<cr>o', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>lT', '<cmd>InsertYesterday<cr>o', { noremap = true, silent = true })
  end,
})
autocmd('BufWritePost', {
  pattern = { '*.ledger', '*.bean', '*.beancount' },
  callback = function()
    -- remove 2 or more empty lines
    vim.cmd [[:silent g/^\n\n/d]]
    vim.cmd [[:silent %s/\t/  /e]]
  end,
})

local function show_balance()
  -- Get the account name under the cursor
  local account = vim.fn.expand '<cWORD>'

  -- Detect filetype and set appropriate command
  local filetype = vim.bo.filetype
  local result

  if filetype == 'ledger' then
    -- If filetype is ledger, use the current file
    local current_file = vim.fn.expand '%:p'
    -- Construct and run the Ledger command
    local cmd = string.format(':Ledger bal %s', account)
    -- Capture the output into a list
    result = vim.fn.systemlist(string.format('ledger -f %s bal %s', current_file, account))
  elseif filetype == 'beancount' then
    -- If filetype is beancount, get the main file path
    local current_file_path = vim.fn.expand '%:p:h'
    local handle = io.popen('git -C "' .. current_file_path .. '" rev-parse --show-toplevel')
    local main_file = handle:read '*l' .. '/main.beancount'

    handle:close() -- Close the handle to free up resources

    -- Construct the bean-query command
    local cmd = string.format('bean-query %s "SELECT account, sum(position) WHERE account ~ \'%s\'"', main_file, account)
    result = vim.fn.systemlist(cmd)
  end

  -- Check if there is a result to display
  if result and #result > 0 then
    -- Create a buffer for the floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)

    -- Define window size and position
    local width = 50
    local height = #result + 2
    local opts = {
      relative = 'cursor',
      row = 1,
      col = 0,
      width = width,
      height = height,
      style = 'minimal',
      border = 'rounded',
    }

    -- Open the window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Keybinding to close the window with 'q'
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
  else
    print('No balance found for account: ' .. account)
  end
end

-- Map it to a key (e.g., <leader>bb for Balance)
vim.keymap.set('n', '<leader>bb', show_balance, { desc = 'Show balance in float' })
