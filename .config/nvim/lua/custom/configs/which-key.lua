local wk = require 'which-key'
wk.add {
  { '<leader>c', group = '[C]ode' },
  { '<leader>c_', hidden = true },
  -- { '<leader>d', group = '[D]ocument' },
  -- { '<leader>d_', hidden = true },
  { '<leader>f', group = '[F]ind' },
  { '<leader>f_', hidden = true },
  { '<leader>h', group = 'Git [H]unk' },
  { '<leader>h_', hidden = true },
  { '<leader>r', group = '[R]ename' },
  { '<leader>r_', hidden = true },
  { '<leader>s', group = '[S]earch' },
  { '<leader>s_', hidden = true },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>t_', hidden = true },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>w_', hidden = true },
}

wk.add {
  mode = { 'n' },
  { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
  { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Find help tags' },
  { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Find Keymaps' },
  { '<leader>fs', '<cmd>Telescope builtin<cr>', desc = 'Telescope builtins' },
  { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Find current word' },
  { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Find Diagnostics' },
  { '<leader>fr', '<cmd>Telescope resume<cr>', desc = 'Find Resume' },
  { '<leader>f.', '<cmd>Telescope oldfiles<cr>', desc = 'Find Recent Files ("." for repeat)' },
  { '<leader><leader>', '<cmd>Telescope buffers<cr>', desc = 'Find existing buffers' },
  {
    '<leader>/',
    function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
    desc = 'Fuzzily search in current buffer',
  },

  -- It's also possible to pass additional configuration options.
  -- --  See `:help telescope.builtin.live_grep()` for information about particular keys
  {
    '<leader>fg',
    function()
      require('telescope.builtin').live_grep {
        prompt_title = 'Live Grep',
        additional_args = { '--glob', './*' },
      }
    end,
    desc = 'Find by grep',
  },
  {
    '<leader>f/',
    function()
      require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    desc = 'Find [/] in Open Files',
  },
  {
    '<leader>fc',
    function()
      require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
    end,
    desc = 'Find Neovim files',
  },
  { '<leader>fb', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>' },
  { '<leader>e', vim.diagnostic.open_float, desc = 'Show diagnostic [E]rror messages' },
  { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostic [Q]uickfix list' },
  { '<Esc>', '<cmd>nohlsearch<CR>', desc = 'remove search highlight' },
  { '<C-h>', '<C-w><C-h>', desc = 'Move focus to the left window' },
  { '<C-l>', '<C-w><C-l>', desc = 'Move focus to the right window' },
  { '<C-j>', '<C-w><C-j>', desc = 'Move focus to the lower window' },
  { '<C-k>', '<C-w><C-k>', desc = 'Move focus to the upper window' },

  { '<A-Left>', '<cmd>vertical resize -5<CR>', desc = 'Minimize split to the left' },
  { '<A-Right>', '<cmd>vertical resize +5<CR>', desc = 'Maximize split to the right' },
  { '<A-Up>', '<cmd>resize +5<CR>', desc = 'Maximize split upwards' },
  { '<A-Down>', '<cmd> resize -5<CR>', desc = 'Minimize split downwards' },

  { '<left>', '<cmd>echo "Use h to move!!"<CR>' },
  { '<right>', '<cmd>echo "Use l to move!!"<CR>' },
  { '<up>', '<cmd>echo "Use k to move!!"<CR>' },
  { '<down>', '<cmd>echo "Use j to move!!"<CR>' },

  {
    '<leader>rl',
    function()
      require('telescope.builtin').find_files { cwd = '~/Documents/Accounts/' }
    end,
    desc = 'Ledger Accounts',
  },
  {
    'K',
    function()
      vim.cmd 'hide Man'
    end,
    desc = 'Get manpages',
  },
  {
    '<leader>fC',
    function()
      require('telescope.builtin').find_files { cwd = '~/.config' }
    end,
    desc = 'Find Configuration files',
  },
  {
    '<leader>mpv',
    function()
      local url = vim.fn.shellescape(vim.fn.getline '.', 1) -- Cache the url for reuse
      vim.cmd('!nohup mpv ' .. url .. ' >/dev/null 2>&1 &') -- Use vim.cmd instead of vim.exec
    end,
    desc = 'Launch mpv on url',
  },
}
wk.add {
  mode = { 'c' },
  {
    'w!!',
    function()
      vim.cmd 'silent! write !sudo tee % >/dev/null | edit!'
    end,
    desc = 'w!!',
  },
}
