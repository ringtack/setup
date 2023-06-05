-- require('kanagawa').setup({})
-- vim.cmd[[colorscheme kanagawa]]

-- require("onedark").setup({
    -- style = 'dark', -- {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}

    -- diagnostics = {
        -- darker = true, -- darker colors for diagnostic
        -- undercurl = true,   -- use undercurl instead of underline for diagnostics
        -- background = false,    -- use background color for virtual text
    -- },
-- })
-- require('onedark').load()

require("onedark").setup({
    -- hide_inactive_statusline = true,

    -- dark_sidebar = true,
    -- highlight_linenumber = true,

    comment_style = "italic",
    function_style = "italic",
})

vim.cmd[[colorscheme onedark]]

vim.cmd('hi IndentBlanklineContextChar guifg=lightgray')
