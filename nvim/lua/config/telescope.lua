-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

-- shortcuts for common Telescope features
-- local options = { noremap = true, silent = true }
-- map('n', 'ff', ':Telescope find_files<CR>', options)


local telescope = require('telescope')

telescope.load_extension('fzf')

telescope.setup({
  defaults = {
    layout_config = {
      preview_width = 0.6
    },
  },
})

