local M = {}

M.dap = {
  plugin = true,
  n = {
    -- ["<leader>dc"] = {"<cmd> DapContinue<CR>"},
    ["<F5>"] = { function() require("dap").continue() end, "DapContinue"},
    ["<F10>"] = { function() require('dap').step_over() end, "StepOver"},
    ["<F11>"] = { function() require('dap').step_into() end, "StepInto"},
    ["<F12>"] = { function() require('dap').step_out() end, "StepOut"},
    ["<leader>dB"] = { function() require('dap').set_breakpoint() end, "SetBreakPoint"},
    ["<leader>dO"] = { function() require('dap').step_out() end, "StepOut"},
    ["<leader>db"] = { function() require('dap').toggle_breakpoint() end, "ToggleBreakPoint"},
    ["<leader>dc"] = { function() require("dap").continue() end, "DapContinue"},
    ["<leader>di"] = { function() require('dap').step_into() end, "StepInto"},
    ["<leader>dl"] = { function() require('dap').run_last() end, "RunLast"},
    ["<leader>dlp"] ={ function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, "BreakPoint log"},
    ["<leader>do"] = { function() require('dap').step_over() end, "StepOver"},
    ["<leader>dr"] = { function() require('dap').repl.open() end, "RestartFrame"},
    ["<leader>dt"] = { "<cmd> DapTerminate<CR>", "Terminate"},
  }
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end
    }
  }
}
M.disabled = {
  n = {
    ["<tab>"] = "",

    ["<S-tab>"] = ""
  }
}
M.abc = {
  n = {
    -- switch splits
    ["<A-l>"] = { "<C-w><S-L>", "Switch split to right" },
    ["<A-h>"] = { "<C-w><S-H>", "Switch split to left" },

    -- resize split
    ["<c-left>"] = { ":vert res -5<CR>" },
    ["<c-right>"] = { ":vert res +5<CR>" },
    ["<c-up>"] = { ":res -5<CR>" },
    ["<c-down>"] = { ":res +5<CR>" },
    -- highlights
    ["<Esc>"] = { ":noh <CR>", "Clear highlights", opts = {silent = true} },

    ["]b"] = {
      function()
        require("nvchad_ui.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["[b"] = {
      function()
        require("nvchad_ui.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

  },
}
return M
