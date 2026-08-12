local opts = { silent = true }

-- keymap(mode, lhs, rhs, desc) -- desc feeds which-key labels
local function keymap(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
end

-- Remap leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
keymap('', '<space>', '<nop>')

-- Press hj fast to return to normal mode
keymap({ 'i', 'v' }, 'hj', '<esc>', 'Escape to normal mode')
keymap('t', 'hj', '<c-\\><c-n>', 'Escape terminal mode')

-- Better escape from terminal
keymap('t', '<esc>', '<c-\\><c-n>', 'Escape terminal mode')

-- Normal --
-- Resize windows (Alt + arrows)
keymap('n', '<A-up>', ':resize -2<cr>', 'Decrease window height')
keymap('n', '<A-down>', ':resize +2<cr>', 'Increase window height')
keymap('n', '<A-left>', ':vertical resize -2<cr>', 'Decrease window width')
keymap('n', '<A-right>', ':vertical resize +2<cr>', 'Increase window width')

-- Clear highlighted search patterns
keymap('n', '<C-l>', '<cmd>let @/=\'\'<cr>', 'Clear search highlight')

-- Delete a character without saving it
keymap('n', 'x', '"_x', 'Delete char (no yank)')

-- Move text up and down
keymap('n', '<A-k>', '<esc>:m .-2<cr>==', 'Move line up')
keymap('n', '<A-j>', '<esc>:m .+1<cr>==', 'Move line down')

-- Redo on shift-u instead of ctrl-r
keymap('n', 'U', '<C-r>', 'Redo')

-- Doom Emacs-style keybindings --

-- SPC f = file
keymap('n', '<leader>fs', ':w<cr>', 'Save file')
keymap('n', '<leader>fS', ':wa<cr>', 'Save all files')
keymap('n', '<leader>fq', ':q<cr>', 'Quit window')

-- SPC b = buffer
keymap('n', '<leader>bd', ':bdelete<cr>', 'Delete buffer')
keymap('n', '<leader>bD', ':bdelete!<cr>', 'Delete buffer (force)')
keymap('n', '<leader>bn', ':bnext<cr>', 'Next buffer')
keymap('n', '<leader>bp', ':bprevious<cr>', 'Previous buffer')
keymap('n', '<leader>bN', ':enew<cr>', 'New buffer')

-- SPC w = window
keymap('n', '<leader>wv', ':vsplit<cr>', 'Split vertical')
keymap('n', '<leader>ws', ':split<cr>', 'Split horizontal')
keymap('n', '<leader>wd', ':close<cr>', 'Close window')
keymap('n', '<leader>wD', ':q<cr>', 'Quit window')
keymap('n', '<leader>wh', '<C-w>h', 'Go to left window')
keymap('n', '<leader>wj', '<C-w>j', 'Go to lower window')
keymap('n', '<leader>wk', '<C-w>k', 'Go to upper window')
keymap('n', '<leader>wl', '<C-w>l', 'Go to right window')
keymap('n', '<leader>wH', '<C-w>H', 'Move window left')
keymap('n', '<leader>wJ', '<C-w>J', 'Move window down')
keymap('n', '<leader>wK', '<C-w>K', 'Move window up')
keymap('n', '<leader>wL', '<C-w>L', 'Move window right')
keymap('n', '<leader>w=', '<C-w>=', 'Balance windows')
keymap('n', '<leader>wm', ':tabnew %<cr>', 'Maximize in new tab')
keymap('n', '<leader>wo', '<C-w>o', 'Close other windows')

-- SPC t = toggle
keymap('n', '<leader>tn', ':set invnumber<cr>', 'Toggle line numbers')
keymap('n', '<leader>tr', ':set invrelativenumber<cr>', 'Toggle relative numbers')
keymap('n', '<leader>tw', ':set invwrap<cr>', 'Toggle wrap')
keymap('n', '<leader>ts', ':set invspell<cr>', 'Toggle spell check')

-- SPC q = quit
keymap('n', '<leader>qq', ':qa<cr>', 'Quit all')
keymap('n', '<leader>qw', ':wqa<cr>', 'Save and quit all')

-- SPC ; = command palette (M-x equivalent)
keymap('n', '<leader>;', ':', 'Command palette')

-- SPC ' = terminal
keymap('n', '<leader>\'', ':terminal<cr>', 'Open terminal')

-- SPC x = text/exec utilities
keymap('n', '<leader>xx', ':source %<cr>', 'Source current file')

-- SPC g = git (magit-style)
keymap('n', '<leader>gg', function() require('neogit').open() end, 'Open Neogit')
keymap('n', '<leader>gS', ':Neogit stage<cr>', 'Stage')
keymap('n', '<leader>gc', ':Neogit commit<cr>', 'Commit')
keymap('n', '<leader>gp', ':Neogit push<cr>', 'Push')
keymap('n', '<leader>gf', ':Neogit pull<cr>', 'Pull')
keymap('n', '<leader>gb', ':Gitsigns blame_line<cr>', 'Blame line')
keymap('n', '<leader>gd', ':Gitsigns diffthis<cr>', 'Diff this')
keymap('n', '<leader>gB', ':Neogit branch<cr>', 'Branch')
keymap('n', '<leader>gl', ':Neogit log<cr>', 'Log')
keymap('n', '<leader>gr', ':Neogit rebase<cr>', 'Rebase')

-- SPC h = help
keymap('n', '<leader>hh', ':help ', 'Help tags')
keymap('n', '<leader>hk', ':Telescope keymaps<cr>', 'Search keymaps')

-- LSP / code navigation (Doom-style)
keymap('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
keymap('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
keymap('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
keymap('n', 'gR', vim.lsp.buf.rename, 'Rename symbol')
keymap('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')

-- Diagnostic navigation (Doom-style [ and ] prefixes)
keymap('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
keymap('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
keymap('n', '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, 'Previous error')
keymap('n', ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, 'Next error')

-- Quick save with Ctrl-s
keymap({ 'n', 'i', 'v' }, '<C-s>', '<esc><cmd>w<cr>', 'Save file')

-- Insert mode navigation (Doom/Emacs-style)
keymap('i', '<C-f>', '<Right>', 'Move right')
keymap('i', '<C-b>', '<Left>', 'Move left')
keymap('i', '<C-a>', '<Home>', 'Move to line start')
keymap('i', '<C-e>', '<End>', 'Move to line end')

-- Insert --
-- Autocomplete brackets, braces, parentheses and angles
keymap('i', '<A-[>', '[]<left>', 'Insert []')
keymap('i', '<A-{>', '{}<left>', 'Insert {}')
keymap('i', '<A-(>', '()<left>', 'Insert ()')
keymap('i', '<A-<>', '<><left>', 'Insert <>')

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', 'Indent left')
keymap('v', '>', '>gv', 'Indent right')

-- Redo on shift-u instead of alt-r
keymap('v', 'U', '<A-r>', 'Redo')

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ':move \'>+1<cr>gv-gv', 'Move selection down')
keymap('x', 'K', ':move \'<-2<cr>gv-gv', 'Move selection up')
keymap('x', '<A-j>', ':move \'>+1<cr>gv-gv', 'Move selection down')
keymap('x', '<A-k>', ':move \'<-2<cr>gv-gv', 'Move selection up')
