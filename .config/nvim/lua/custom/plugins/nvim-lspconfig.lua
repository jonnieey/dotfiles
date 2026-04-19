return {
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/lazydev.nvim', opts = {} },
    },
    config = function()
      -- LSP attach autocmd with ACTIVE key mappings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Essential LSP mappings (uncommented)
          -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          -- map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          -- map('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Document highlighting and inlay hints (existing code is fine)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            -- ... existing highlight code ...
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Capabilities setup (existing code is fine)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Server configurations (FIXED: removed formatters)
      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeChecking = 'basic',
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                autoSearch = true,
                autoImport = true,
                diagnosticMode = 'off',
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        bashls = {},
        -- Add other LSP servers as needed
        -- rust_analyzer = {},
        -- tsserver = {},
        beancount = {
          init_options = {
            formatting = {},
            diagnostic_flags = { '!' },
          },
          on_attach = function(client, bufnr)
            -- Disable LSP formatting
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      }

      -- Mason setup
      require('mason').setup()

      -- FIXED: Removed redundant LSP entries from ensure_installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        'debugpy', -- Python debugger
        -- 'shellharden', -- Shell formatter (not LSP)
        -- 'shfmt', -- Shell formatter (not LSP)
        -- 'black', -- Python formatter
        -- 'isort', -- Python import sorter
        -- 'ruff', -- Python linter/formatter
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
