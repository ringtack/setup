local g = vim.g
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

-- Easy status
map('n', '<leader>gs', ':G <CR>', {})

-- Better diff management
map('n', 'd2', ':diffget //2<CR>', {})
map('n', 'd3', ':diffget //3<CR>', {})
