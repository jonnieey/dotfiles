local g = vim.g
g.Tlist_Auto_Highlight_Tag = 1
g.Tlist_Auto_Open = 0
g.Tlist_Auto_Update = 1
g.Tlist_Compact_Format = 1
g.Tlist_Display_Tag_Scope = 1
g.Tlist_Enable_Fold_Column = 1
g.Tlist_File_Fold_Auto_Close = 1
g.Tlist_GainFocus_On_ToggleOpen = 1
g.Tlist_Inc_Winwidth = 1
g.Tlist_Show_One_File = 1
g.Tlist_Sort_Type = "order"
g.Tlist_Use_Right_Window = 1
g.Tlist_WinWidth = 40
vim.api.nvim_set_keymap("n", "<leader>t", [[:TlistToggle<CR>]], { noremap = true, silent = true })
