return {
  'hxueh/beancount.nvim',
  ft = { 'beancount', 'bean' },
  lazy = true,
  config = function()
    require 'custom.configs.beancount'
    require 'custom.configs.vim-ledger'
    -- Treesitter setup
    require('nvim-treesitter.configs').setup {
      highlight = { enable = true },
      incremental_selection = { enable = true },
      indent = { enable = true },
    }
  end,
}
