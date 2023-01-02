require("which-key").setup({
    show_help = false,
    show_keys = false,
})

-- Shorten timeout length
vim.o.timeoutlen = 500

-- Manually open WhichKey menu
vim.keymap.set('', '<space>wk', ':WhichKey<CR>', { noremap = true, silent = true })
