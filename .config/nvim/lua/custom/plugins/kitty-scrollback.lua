return {
  'mikesmithgh/kitty-scrollback.nvim',
  enabled = true,
  lazy = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
  event = { 'User KittyScrollbackLaunch' },
  -- version = '*', -- latest stable version, may have breaking changes if major version changed
  -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
  config = function()
    require('kitty-scrollback').setup {
      {
        -- KsbCallbacks? fire and forget callback functions
        callbacks = {
          -- fun(kitty_data: KsbKittyData, opts: KsbOpts)? callback executed after initializing kitty-scrollback.nvim
          after_setup = nil,
          -- fun(kitty_data: KsbKittyData, opts: KsbOpts)? callback executed after launch started to process the scrollback buffer
          after_launch = nil,
          -- fun(kitty_data: KsbKittyData, opts: KsbOpts)?  callback executed after scrollback buffer is loaded and cursor is positioned
          after_ready = nil,
          -- fun(paste_window_data: KsbPasteWindowData, kitty_data: KsbKittyData, opts: KsbOpts)? callback executed after the paste window is opened or resized
          after_paste_window_ready = nil,
        },
        -- boolean? if true, enabled all default keymaps
        keymaps_enabled = true,
        -- boolean? if true, restore options that were modified while processing the scrollback buffer
        restore_options = false,
        -- KsbHighlights? highlight overrides
        highlight_overrides = {
          -- table? status window Normal highlight group
          KittyScrollbackNvimStatusWinNormal = {},
          -- table? status window heart icon highlight group
          KittyScrollbackNvimStatusWinHeartIcon = {},
          -- table? status window spinner icon highlight group
          KittyScrollbackNvimStatusWinSpinnerIcon = {},
          -- table? status window ready icon highlight group
          KittyScrollbackNvimStatusWinReadyIcon = {},
          -- table? status window kitty icon highlight group
          KittyScrollbackNvimStatusWinKittyIcon = {},
          -- table? status window vim icon highlight group
          KittyScrollbackNvimStatusWinNvimIcon = {},
          -- table? paste window Normal highlight group
          KittyScrollbackNvimPasteWinNormal = {},
          -- table? paste window FloatBorder highlight group
          KittyScrollbackNvimPasteWinFloatBorder = {},
          -- table? paste window FloatTitle highlight group
          KittyScrollbackNvimPasteWinFloatTitle = {},
          -- table? scrollback buffer window Visual selection highlight group
          KittyScrollbackNvimVisual = {},
          -- table? scrollback buffer window Normal highlight group
          KittyScrollbackNvimNormal = {},
        },
        -- KsbStatusWindowOpts? options for status window indicating that kitty-scrollback.nvim is ready
        status_window = {
          -- boolean If true, show status window in upper right corner of the screen
          enabled = true,
          -- boolean If true, use plaintext instead of nerd font icons
          style_simple = false,
          -- boolean If true, close the status window after kitty-scrollback.nvim is ready
          autoclose = false,
          -- boolean If true, show a timer in the status window while kitty-scrollback.nvim is loading
          show_timer = false,
          -- KsbStatusWindowIcons? Icons displayed in the status window
          icons = {
            -- string kitty status window icon
            kitty = '󰄛',
            -- string heart string heart status window icon
            heart = '󰣐', -- variants 󰣐 |  |  | ♥ |  | 󱢠 | 
            -- string nvim status window icon
            nvim = '', -- variants  |  |  | 
          },
        },

        -- KsbPasteWindowOpts? options for paste window that sends commands to Kitty
        paste_window = {
          --- BoolOrFn? If true, use Normal highlight group. If false, use NormalFloat
          highlight_as_normal_win = nil,
          -- string? The filetype of the paste window. If nil, use the shell that is configured for kitty
          filetype = nil,
          -- boolean? If true, hide mappings in the footer when the paste window is initially opened
          hide_footer = false,
          -- integer? The winblend setting of the window, see :help winblend
          winblend = 0,
          -- KsbWinOptsOverride? Paste float window overrides, see nvim_open_win() for configuration
          winopts_overrides = nil,
          -- KsbFooterWinOptsOverride? Paste footer window overrides, see nvim_open_win() for configuration
          footer_winopts_overrides = nil,
          -- string? register used during yanks to paste window, see :h registers
          yank_register = '*',
          -- boolean? If true, the yank_register copies content to the paste window. If false, disable yank to paste window
          yank_register_enabled = true,
        },

        -- KsbKittyGetText? options passed to get-text when reading scrollback buffer, see kitty @ get-text --help
        kitty_get_text = {
          -- boolean If true, the text will include the ANSI formatting escape codes for colors, bold, italic, etc.
          ansi = true,
          -- string What text to get. The default of screen means all text currently on the screen. all means all the screen+scrollback and selection means the currently selected text. first_cmd_output_on_screen means the output of the first command that was run in the window on screen. last_cmd_output means the output of the last command that was run in the window. last_visited_cmd_output means the first command output below the last scrolled position via scroll_to_prompt. last_non_empty_output is the output from the last command run in the window that had some non empty output. The last four require shell_integration to be enabled. Choices: screen, all, first_cmd_output_on_screen, last_cmd_output, last_non_empty_output, last_visited_cmd_output, selection
          extent = 'all',
          -- boolean If true, clear the selection in the matched window, if any.
          clear_selection = true,
        },
        -- boolean? if true execute :checkhealth kitty-scrollback and skip setup
        checkhealth = false,
        -- string? Sets the mode for coloring the Visual highlight group in the scrollback buffer window. darken uses a darkened version of the Normal highlight group to improve readability. kitty uses the colors defined for selection_foreground and selection_background in your Kitty configuration. nvim uses the default colors defined in the Visual highlight group. reverse reverses the foreground and background colors of the visual selection.
        visual_selection_highlight_mode = 'darken',
        -- integer? Temporary column width during get-text operation to avoid hard wrapping (larger values may impact performance), see :h columns
        scrollback_columns = 300,
      },
    }
  end,
}
