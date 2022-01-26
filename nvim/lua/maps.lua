---- MAPS SECTION ----

-- shorten some commands
local o = vim.o
local g = vim.g
local cmd = vim.cmd
local nvim_exec = vim.api.nvim_exec
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap



-- Set leader and localleader to comma (,)
g.mapleader = ','
g.maplocalleader = ','

-- allow easy split window creation
local options = { noremap = true, silent = true }         -- mapping options
map('n', '<Leader>d', ':sp<CR>', options)   -- horizontal split window creation
map('n', '<Leader>r', ':vsp<CR>', options)  -- vertical split window creation
-- simplify window navigation
map('n', '<C-J>', '<C-W><C-J>', options)    -- down window
map('n', '<C-K>', '<C-W><C-K>', options)    -- up window
map('n', '<C-H>', '<C-W><C-H>', options)    -- left window
map('n', '<C-L>', '<C-W><C-L>', options)    -- right window

-- simplify buffer navigation and deletion
map('n', '<Leader>]', ':bnext<CR>', options)
map('n', '<Leader>[', ':bprev<CR>', options)
map('n', '<Leader><Esc>', ':bd<CR>', options)

-- Line transforms with Alt
map('n', '<A-j>', ':m .+1<CR>==', options)
map('n', '<A-k>', ':m .-2<CR>==', options)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', options)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', options)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", options)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", options)

-- remember meaningful j and k as jumps on jumplist
--	TODO: convert this to pure Lua eventually? I'm too lazy rn
nvim_exec([[
nnoremap <expr> k (v:count > 10 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 10 ? "m'" . v:count : '') . 'gj'
]], false)




-- disable Ex mode, whatever that is
map('n', 'Q', '<Nop>', {})


