return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'nvim-neotest/nvim-nio',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'pytest',
          },
        },
      }
      local wk = require 'which-key'
      wk.add {
        {
          '<leader>dT',
          function()
            require('neotest').run.run { strategy = 'dap' }
          end,
          desc = 'Run Debugger on tests',
        },
      }
    end,
  },
}
