-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

-- shortcuts for common Telescope features
local options = { noremap = true, silent = true }
map('n', '<leader>lg', ':Telescope live_grep<CR>', options)


local telescope = require('telescope')

telescope.load_extension('fzf')
-- telescope.load_extension('ui-select')

telescope.setup({
  defaults = {
    layout_config = {
      preview_width = 0.6
    },
  },
  -- extensions = {
    -- ["ui-select"] = {
      -- require("telescope.themes").get_dropdown {
        -- -- even more opts
      -- }
    -- }
  -- }
})

