local cmd = vim.cmd
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap


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
        update_root = false,
        ignore_list = {},
    },
    view = {
        width = 25,
        side = 'left',
    },
    actions = {
        open_file = {
            resize_window = true,
        },
    },
    renderer = {
        highlight_opened_files = "icon",
        add_trailing = true,
        group_empty = true,
    }
}

