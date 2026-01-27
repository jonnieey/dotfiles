local wk = require 'which-key'
local Snacks = require 'snacks'
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
  { '<leader>ff', '<cmd>lua Snacks.picker.smart()<cr>', desc = 'Find files' },
  { '<leader>fk', '<cmd>lua Snacks.picker.keymaps()<cr>', desc = 'Find Keymaps' },
  { '<leader>fw', '<cmd>lua Snacks.picker.grep_word()<cr>', desc = 'Find current word' },
  { '<leader>fd', '<cmd>lua Snacks.picker.diagnostics()<cr>', desc = 'Find Diagnostics' },
  { '<leader>fr', '<cmd>lua Snacks.picker.resume()<cr>', desc = 'Find Resume' },
  { '<leader>f.', '<cmd>lua Snacks.picker.recent()<cr>', desc = 'Find Recent Files ("." for repeat)' },
  { '<leader><leader>', '<cmd>lua Snacks.picker.buffers()<cr>', desc = 'Find existing buffers' },
  { '<leader>fg', '<cmd>lua Snacks.picker.grep()<cr>', desc = 'Find by grep' },
  { '<leader>f/', '<cmd>lua Snacks.picker.grep_buffers()<cr>', desc = 'Find [/] in Open Files' },
  { '<leader>fb', '<cmd>lua Snacks.explorer()<cr>' },
  {
    '<leader>/',
    function()
      Snacks.picker.colorschemes()
    end,
    desc = 'Fuzzily search in current buffer',
  },
  {
    '<leader>fT',
    function()
      require('aerial').snacks_picker()
    end,
    desc = 'Fuzzily search in current buffer',
  },

  {
    '<leader>fc',
    function()
      Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
    end,
    desc = 'Find Neovim files',
  },
  {
    '<A-/>',
    function()
      Snacks.terminal()
    end,
    desc = 'Toggle Terminal',
  },
  { '<leader>lt', '<cmd>AerialToggle<cr>', desc = 'Toggle Aerial' },
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
    'gd',
    function()
      Snacks.picker.lsp_definitions()
    end,
    desc = 'Goto Definition',
  },
  {
    'gD',
    function()
      Snacks.picker.lsp_declarations()
    end,
    desc = 'Goto Declaration',
  },
  {
    'gr',
    function()
      Snacks.picker.lsp_references()
    end,
    nowait = true,
    desc = 'References',
  },
  {
    'gI',
    function()
      Snacks.picker.lsp_implementations()
    end,
    desc = 'Goto Implementation',
  },
  {
    '<leader>lD',
    function()
      Snacks.picker.lsp_type_definitions()
    end,
    desc = 'Goto T[y]pe Definition',
  },
  {
    '<leader>lds',
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = 'LSP Symbols',
  },
  {
    '<leader>lws',
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = 'LSP Workspace Symbols',
  },

  { '<leader>lrn', vim.lsp.buf.rename, desc = '[R]e[n]ame' },
  { '<leader>lca', vim.lsp.buf.code_action, desc = '[C]ode [A]ction' },
  { '<leader>K', vim.lsp.buf.hover, desc = 'Hover Documentation' },
  { 'gD', vim.lsp.buf.declaration, desc = '[G]oto [D]eclaration' },

  {
    '<leader>rl',
    function()
      Snacks.picker.files { cwd = '~/Documents/Finances/' }
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
      Snacks.picker.files { cwd = '~/.config' }
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

wk.add {
  mode = { 'v' },
  nowait = true,
  remap = false,
  { '<leader>gT', ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = 'ChatNew tabnew' },
  { '<leader>gV', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'ChatNew vsplit' },
  { '<leader>gX', ":<C-u>'<,'>GpChatNew split<cr>", desc = 'ChatNew split' },
  { '<leader>ga', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
  { '<leader>gb', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
  { '<leader>gc', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
  { '<leader>gg', group = 'generate into new ..' },
  { '<leader>gge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
  { '<leader>ggn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
  { '<leader>ggp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
  { '<leader>ggt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },
  { '<leader>ggv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
  { '<leader>gi', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
  { '<leader>gn', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
  { '<leader>gl', '<cmd>GpSelectAgent<cr>', desc = 'Select Agent' },
  { '<leader>gp', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
  { '<leader>gr', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
  { '<leader>gs', '<cmd>GpStop<cr>', desc = 'GpStop' },
  { '<leader>gt', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
  { '<leader>gw', group = 'Whisper' },
  { '<leader>gwa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append' },
  { '<leader>gwb', ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = 'Whisper Prepend' },
  { '<leader>gwe', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
  { '<leader>gwn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
  { '<leader>gwp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
  { '<leader>gwr', ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = 'Whisper Rewrite' },
  { '<leader>gwt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
  { '<leader>gwv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
  { '<leader>gww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
  { '<leader>gx', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },
}

wk.add {
  mode = { 'n' },
  nowait = true,
  remap = false,
  { '<leader>gT', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
  { '<leader>gV', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
  { '<leader>gX', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
  { '<leader>ga', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
  { '<leader>gb', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
  { '<leader>gc', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
  { '<leader>gf', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
  { '<leader>gg', group = 'generate into new ..' },
  { '<leader>gge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
  { '<leader>ggn', '<cmd>GpNew<cr>', desc = 'GpNew' },
  { '<leader>ggp', '<cmd>GpPopup<cr>', desc = 'Popup' },
  { '<leader>ggt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
  { '<leader>ggv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
  { '<leader>gn', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
  { '<leader>gl', '<cmd>GpSelectAgent<cr>', desc = 'Select Agent' },
  { '<leader>gr', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
  { '<leader>gs', '<cmd>GpStop<cr>', desc = 'GpStop' },
  { '<leader>gt', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
  { '<leader>gw', group = 'Whisper' },
  { '<leader>gwa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
  { '<leader>gwb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
  { '<leader>gwe', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
  { '<leader>gwn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
  { '<leader>gwp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
  { '<leader>gwr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
  { '<leader>gwt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
  { '<leader>gwv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
  { '<leader>gww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
  { '<leader>gx', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
}
wk.add {
  mode = { 'i' },
  nowait = true,
  remap = false,
  { '<leader>gT', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
  { '<leader>gV', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
  { '<leader>gX', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
  { '<leader>ga', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
  { '<leader>gb', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
  { '<leader>gc', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
  { '<leader>gf', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
  { '<leader>gg', group = 'generate into new ..' },
  { '<leader>gge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
  { '<leader>ggn', '<cmd>GpNew<cr>', desc = 'GpNew' },
  { '<leader>ggp', '<cmd>GpPopup<cr>', desc = 'Popup' },
  { '<leader>ggt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
  { '<leader>ggv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
  { '<leader>gn', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
  { '<leader>gl', '<cmd>GpSelectAgent<cr>', desc = 'Select Agent' },
  { '<leader>gr', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
  { '<leader>gs', '<cmd>GpStop<cr>', desc = 'GpStop' },
  { '<leader>gt', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
  { '<leader>gw', group = 'Whisper' },
  { '<leader>gwa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
  { '<leader>gwb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
  { '<leader>gwe', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
  { '<leader>gwn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
  { '<leader>gwp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
  { '<leader>gwr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
  { '<leader>gwt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
  { '<leader>gwv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
  { '<leader>gww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
  { '<leader>gx', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
}
