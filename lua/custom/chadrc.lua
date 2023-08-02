---@type ChadrcConfig 
--
local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------
g.mapleader = "\\"
g.loaded_python3_provider=1

-------------------------------------- options ------------------------------------------
opt.relativenumber = true
opt.colorcolumn = "80"
opt.cursorline = true
opt.scrolloff = 12

------------------------------------- autocmd -------------------------------------------
local M = {}

M.ui = {theme = 'catppuccin'}
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"

return M
