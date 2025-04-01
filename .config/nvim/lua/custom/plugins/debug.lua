-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'debugpy',
      },
    }

    require('dap').configurations.python = {
      { type = 'python', request = 'launch', name = 'My custom launch configuration', justMyCode = false, program = '${file}' },
    }

    local dap_python = require 'dap-python' -- Cache module to avoid repeated require calls
    dap_python.setup '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
    dap_python.test_runner = 'pytest'
    -- Basic debugging keymaps, feel free to change to your liking!
    local wk = require 'which-key'
    wk.add {
      { '<leader>d', group = 'Debug' },
      { '<leader>d_', hidden = true },
    }
    wk.add {
      mode = { 'v' },
      {
        '<leader>dl',
        function()
          dap_python.debug_selection()
        end,
        desc = 'Debug selection',
      },
    }
    wk.add {
      mode = { 'n' },
      { '<leader>dC', dap.set_breakpoint, desc = 'Conditional Breakpoint' },
      {
        '<leader>dE',
        function()
          require('dapui').eval(vim.fn.input '[Expression] > ')
        end,
        desc = 'Evaluate Input',
      },
      { '<leader>dR', dap.run_to_cursor, desc = 'Run to Cursor' },
      {
        '<leader>dS',
        function()
          require('dap.ui.widgets').scopes()
        end,
        desc = 'Scopes',
      },
      {
        '<leader>dU',
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle UI',
      },
      { '<leader>db', dap.step_back, desc = 'Step Back' },
      { '<leader>dc', dap.continue, desc = 'Continue' },
      { '<leader>dd', dap.disconnect, desc = 'Disconnect' },
      {
        '<leader>de',
        function()
          require('dapui').eval()
        end,
        desc = 'Evaluate',
      },
      { '<leader>dg', dap.session, desc = 'Get Session' },
      {
        '<leader>dh',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Hover Variables',
      },
      { '<leader>di', dap.step_into, desc = 'Step Into' },
      {
        '<leader>dk',
        function()
          dap_python.test_class()
        end,
        desc = 'Debug Class',
      },
      {
        '<leader>dm',
        function()
          dap_python.test_method()
        end,
        desc = 'Debug method',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause.toggle()
        end,
        desc = 'Pause',
      },
      { '<leader>dq', dap.close, desc = 'Quit' },
      { '<leader>dr', dap.repl.toggle, desc = 'Toggle Repl' },
      { '<leader>ds', dap.continue, desc = 'Start' },
      { '<leader>dt', dap.toggle_breakpoint, desc = 'Toggle Breakpoint' },
      { '<leader>du', dap.step_out, desc = 'Step Out' },
      { '<leader>dx', dap.terminate, desc = 'Terminate' },
      { '<leader>dX', dap.clear_breakpoints, desc = 'Clear all breakpoints' },
      { '<F5>', dap.continue, desc = 'Continue' },
      { '<F6>', dap.step_over, desc = 'Step Over' },
      { '<F7>', dap.step_into, desc = 'Step Into' },
      { '<F8>', dap.step_out, desc = 'Step Out' },
      {
        '<leader>dB',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = '[D]ebug: Set Breakpoint',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F10>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    --
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
  end,
}
