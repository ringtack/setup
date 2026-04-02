-- Keymap <C-n> defined in plugins.lua keys spec (registered at startup, not on plugin load).

-- Change highlights
vim.api.nvim_set_hl(0, 'NvimTreeFolderName',       { fg = '#61afef' })
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon',       { fg = '#61afef' })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFolderName', { fg = '#61afef' })

-- Disable statusline inside NvimTree
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter' }, {
    callback = function()
        vim.o.laststatus = (vim.fn.bufname('%') == 'NvimTree') and 0 or 2
    end,
})

require('nvim-tree').setup {
    update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
    },
    git = {
        ignore = false,
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
