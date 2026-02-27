vim.g.tagbar_type_vb = {
  ctagstype = 'LibreOfficeBasic',
  kinds = {
    's:subroutines:0:1',
    'f:functions:0:1',
    'v:variables:0:0',
    'c:constants:0:0',
    't:types:0:1',
    'l:labels:0:0',
  },
  sort = 0,
  sro = '::',
  kind2scope = {
    s = 'sub',
    f = 'function',
    t = 'type',
  },
  scope2kind = {
    sub = 's',
    type = 't',
  },
}
vim.g.tagbar_compact = 1
vim.g.tagbar_autoshowtag = 0
