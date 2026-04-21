return {
  'hxueh/beancount.nvim',
  ft = { 'beancount', 'bean' },
  lazy = true,
  config = function()
    -- require('nvim-treesitter.configs').setup {
    --   highlight = { enable = true },
    --   incremental_selection = { enable = true },
    --   indent = { enable = true },
    -- }
    require 'custom.configs.beancount'
  end,
}
