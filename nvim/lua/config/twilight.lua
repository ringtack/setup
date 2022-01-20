-- syntax: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

require('twilight').setup{
  context = 16,
}

map('n', '<Leader>tw', ':Twilight<CR>', { noremap = true, silent = true})
