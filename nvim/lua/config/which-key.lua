require("which-key").setup({})

-- Shorten timeout length
vim.o.timeoutlen = 500

-- Manually open WhichKey menu
vim.keymap.set('', '<space>wk', ':WhichKey<CR>', { noremap = true, silent = true, desc = 'which-key: show all keymaps' })
