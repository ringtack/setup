require('twilight').setup {
    context = 15,
}

vim.keymap.set('n', '<Leader>tw', ':Twilight<CR>',
    { noremap = true, silent = true, desc = 'twilight: toggle dim inactive code' })
