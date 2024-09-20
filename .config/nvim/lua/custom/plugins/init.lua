return {
  {

    { 'tpope/vim-sleuth', lazy = false }, -- Detect tabstop and shiftwidth automatically
    { 'tpope/vim-fugitive', lazy = false },
    { 'tpope/vim-surround', lazy = false },
    { 'numToStr/Comment.nvim', lazy = false, opts = {} },
    {
      'liuchengxu/vista.vim',
      lazy = false,
      config = function()
        vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
      end,
    },
    { -- Useful plugin to show you pending keybinds.
      'folke/which-key.nvim',
      event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      config = function() -- This is the function that runs, AFTER loading
        require 'custom.configs.which-key'
      end,
    },

    {
      'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,
      init = function()
        vim.cmd.colorscheme 'catppuccin'
        vim.cmd.hi 'Comment gui=none'
      end,
    },
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    -- require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    -- require 'kickstart.plugins.neo-tree',
    -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
    { import = 'custom.plugins' },
    --
    {
      'ledger/vim-ledger',
      lazy = false,
      config = function()
        require 'custom.configs.vim-ledger'
      end,
    },
    { 'junegunn/vim-easy-align', lazy = true, ft = { 'ledger' } },
    {
      'robitx/gp.nvim',
      config = function()
        require 'custom.configs.gp'
      end,
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    },
    {
      'milanglacier/yarepl.nvim',
      config = function()
        require 'custom.configs.yarepl'
      end,
    },
  },
}
