local hop = require('hop')
hop.setup({
    -- teasing = false,
})



-- Augment fF/tT functionality
local directions = require('hop.hint').HintDirection
local opts = { remap = true, silent = true }

local fHopChar = function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end
local FHopChar = function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end
local tHopChar = function()
    hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end
local THopChar = function()
    hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end

vim.keymap.set('', 'f', fHopChar, opts)
vim.keymap.set('', 'F', FHopChar, opts)
vim.keymap.set('', 't', tHopChar, opts)
vim.keymap.set('', 'T', THopChar, opts)

-- Set default mappings for HopWord
vim.keymap.set('', '<leader>w', hop.hint_words, opts)
