-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

-- Toggle with <C-n>
map('n', '<Leader>so', ':SymbolsOutline <CR>', { noremap = true, silent = true})

require("symbols-outline").setup({
    width = 20,
    show_numbers = true,
    show_relative_numbers = true,
})
