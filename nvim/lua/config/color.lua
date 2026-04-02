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

vim.cmd.colorscheme('onedark')

-- Inlay hints (rust-analyzer type annotations, parameter names, etc.)
-- Default 'Conceal' is near-invisible on dark backgrounds; use a readable muted blue-gray.
vim.api.nvim_set_hl(0, 'LspInlayHint', { link = 'Comment' })
