return {
  {
    'EvanQuan/vmath-plus',
    lazy = false,

    config = function()
      vim.keymap.set('n', '++', '<Plug>(vmath_plus#normal_analyze)')
      vim.keymap.set('x', '++', '<Plug>(vmath_plus#visual_analyze)')
    end,
  },
}
