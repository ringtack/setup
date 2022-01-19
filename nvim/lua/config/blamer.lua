local g = vim.g
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

g.blamer_enabled = 0
g.blamer_delay = 250
g.blamer_show_in_visual_modes = 0
g.blamer_show_in_insert_modes = 0
g.blamer_date_format = '%d/%m/%y'

map('n', '<leader>b', ':BlamerToggle <CR>', { noremap = true })
