-- set leader keys before anything else so every <leader> mapping
-- (including lazy.nvim's lazy-loaded keys) resolves to the right key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('user/keymaps')
require('user/options')
require('user/lsp')
require('lazy-startup')
