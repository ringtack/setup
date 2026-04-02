---- MAPS SECTION ----

local g = vim.g
local nvim_exec = vim.api.nvim_exec
local map = vim.keymap.set

-- Set leader and localleader to comma (,)
g.mapleader = ','
g.maplocalleader = ','

local o = { noremap = true, silent = true }

-- Window splits
map('n', '<Leader>d', ':sp<CR>',  vim.tbl_extend('force', o, { desc = 'window: horizontal split' }))
map('n', '<Leader>r', ':vsp<CR>', vim.tbl_extend('force', o, { desc = 'window: vertical split' }))

-- Window navigation
map('n', '<C-J>', '<C-W><C-J>', vim.tbl_extend('force', o, { desc = 'window: move down' }))
map('n', '<C-K>', '<C-W><C-K>', vim.tbl_extend('force', o, { desc = 'window: move up' }))
map('n', '<C-H>', '<C-W><C-H>', vim.tbl_extend('force', o, { desc = 'window: move left' }))
map('n', '<C-L>', '<C-W><C-L>', vim.tbl_extend('force', o, { desc = 'window: move right' }))

-- Buffer navigation
map('n', '<Leader>]',   ':bnext<CR>',   vim.tbl_extend('force', o, { desc = 'buffer: next' }))
map('n', '<Leader>[',   ':bprev<CR>',   vim.tbl_extend('force', o, { desc = 'buffer: previous' }))
map('n', '<Leader><Esc>', ':Bdelete<CR>', vim.tbl_extend('force', o, { desc = 'buffer: delete' }))

-- Line movement with Alt
map('n', '<A-j>', ':m .+1<CR>==',        vim.tbl_extend('force', o, { desc = 'line: move down' }))
map('n', '<A-k>', ':m .-2<CR>==',        vim.tbl_extend('force', o, { desc = 'line: move up' }))
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', vim.tbl_extend('force', o, { desc = 'line: move down (insert)' }))
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', vim.tbl_extend('force', o, { desc = 'line: move up (insert)' }))
map('v', '<A-j>', ":m '>+1<CR>gv=gv",   vim.tbl_extend('force', o, { desc = 'line: move down (visual)' }))
map('v', '<A-k>', ":m '<-2<CR>gv=gv",   vim.tbl_extend('force', o, { desc = 'line: move up (visual)' }))

-- Large j/k jumps land in jumplist so <C-o>/<C-i> can navigate back
nvim_exec([[
nnoremap <expr> k (v:count > 10 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 10 ? "m'" . v:count : '') . 'gj'
]], false)

-- Disable Ex mode
map('n', 'Q', '<Nop>', {})
