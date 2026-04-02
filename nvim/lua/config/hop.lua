local hop = require('hop')
hop.setup({})

local directions = require('hop.hint').HintDirection
local o = { remap = true, silent = true }

vim.keymap.set('', 'f', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, vim.tbl_extend('force', o, { desc = 'hop: jump forward to char' }))

vim.keymap.set('', 'F', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, vim.tbl_extend('force', o, { desc = 'hop: jump backward to char' }))

vim.keymap.set('', 't', function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, vim.tbl_extend('force', o, { desc = 'hop: jump forward before char' }))

vim.keymap.set('', 'T', function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, vim.tbl_extend('force', o, { desc = 'hop: jump backward before char' }))

vim.keymap.set('', '<leader>w', hop.hint_words,
    vim.tbl_extend('force', o, { desc = 'hop: jump to word' }))
