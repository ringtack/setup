local g = vim.g
local cmd = vim.cmd
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 1

-- Toggle with <C-n>
map('n', '<C-n>', ':NvimTreeToggle <CR>', { noremap = true, silent = true})

-- Change highlights
cmd([[
hi NvimTreeFolderName guifg=#61afef
hi NvimTreeFolderIcon guifg=#61afef
hi NvimTreeOpenedFolderName guifg=#61afef
]])

-- disable statusline in NvimTree
cmd([[
au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
]])

require('nvim-tree').setup {
    open_on_tab = true,
    update_focused_file = {
        enable = true,
        updated_cwd = false,
        ignore_list = {},
    },
    view = {
        width = 25,
        height = 25,
        side = 'left',
        auto_resize = true,
    },
}
