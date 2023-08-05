local M = {}

M.dap = {
  plugin = true,
  n = {
    --- Debugger
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
    ["<leader>dpr"] = { function() require("dap-python").test_method() end, "DAP Py Test method" } } }

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

    ---- buffers ----
    ["]b"] = { function() require("nvchad_ui.tabufline").tabuflineNext() end, "Goto next buffer", },
    ["[b"] = { function() require("nvchad_ui.tabufline").tabuflinePrev() end, "Goto prev buffer", },


    ["<leader>fa"] = { function() require("telescope.builtin").find_files({cwd="~/.config/nvim/lua/custom/"}) end, "Find files" },
    ["<leader>fb"] = { function() require("telescope.builtin").buffers() end, "Find buffers" },
    ["<leader>fc"] = { function() require("telescope.builtin").grep_string() end, "Find for word under cursor" },
    ["<leader>fC"] = { function() require("telescope.builtin").commands() end, "Find commands" },
    ["<leader>ff"] = { function() require("telescope.builtin").find_files() end, "Find files" },
    ["<leader>fF"] = { function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end, "Find all files", },
    ["<leader>fh"] = { function() require("telescope.builtin").help_tags() end, "Find help" },
    ["<leader>fk"] = { function() require("telescope.builtin").keymaps() end, "Find keymaps" },
    ["<leader>fm"] = { function() require("telescope.builtin").man_pages() end, "Find man" },
    ["<leader>fo"] = { function() require("telescope.builtin").oldfiles() end, "Find history" },
    ["<leader>fr"] = { function() require("telescope.builtin").registers() end, "Find registers" },
    ["<leader>ft"] = { "<cmd>Telescope themes<cr>" , "Find themes" },
    ["<leader>fw"] = { function() require("telescope.builtin").live_grep() end, "Find words" },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep {
          additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
        }
      end,
      "Find words in all files",
    },

      ---- LSP bindings ----------------
    ["[d"] = { function() vim.diagnostic.goto_prev() end, "Previous diagnostic", },
    ["]d"] = { function() vim.diagnostic.goto_next() end, "Next diagnostic", },
    ["gD"] = { function() vim.lsp.buf.declaration() end, "LSP declaration", },
    ["gI"] = { function() vim.lsp.buf.implementation() end, "LSP implementation", },
    ["gT"] = { function() vim.lsp.buf.type_definition() end, "LSP type definition", },
    ["gd"] = { function() vim.lsp.buf.definition() end, "LSP definition", },
    ["gl"] = { function() vim.diagnostic.open_float() end, "Hover diagnostics", },
    ["<leader>la"] = { function() vim.lsp.buf.code_action() end, "LSP code action"},
    ["<leader>lf"] = { function() vim.lsp.buf.format { async = true } end, "LSP formatting", },
    ["<leader>lH"] = { function() vim.lsp.buf.hover() end, "LSP hover"},
    ["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, "LSP signature help"},
    ["<leader>li"] = { "<cmd>LspInfo<cr>", "LSP Info" },
    ["<leader>lL"] = { function() vim.lsp.codelens.run() end, "Lsp CodeLens Run"},
    ["<leader>ll"] = { function() vim.lsp.codelens.refresh() end, "Lsp CodeLens Refresh"},
    ["<leader>lR"] = { function() vim.lsp.buf.references() end, "LSP rename"},
    ["<leader>lr"] = { function() vim.lsp.buf.rename() end, "LSP rename"},


    ["<leader>t"] = { [[:TlistToggle<CR>]], "TagList" },

    ['<leader>rl'] = {
      function()
        require("telescope.builtin").find_files({cwd="~/.linux/learn/ledger-cli/LedgerAccounts"})
      end,
      "Ledger Accounts"
    },
  },
  v = {
    ["<leader>la"] = { function() vim.lsp.buf.code_action() end, "LSP code action"},
  },
}
return M
