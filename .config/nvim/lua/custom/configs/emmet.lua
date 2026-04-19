require('lspconfig').emmet_language_server.setup {
  filetypes = {
    'astro',
    'css',
    'eruby',
    'html',
    'javascript',
    'javascriptreact',
    'less',
    'php',
    'pug',
    'sass',
    'scss',
    'typescriptreact',
  },
  init_options = {
    preferences = {
      showAbbreviationSuggestions = true,
    },
  },
}
