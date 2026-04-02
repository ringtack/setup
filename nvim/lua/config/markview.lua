require("markview").setup({
    preview = {
        -- Start with preview enabled; toggle off when you need raw markdown
        enable = true,
        -- Debounce rendering (ms) — increase if editing feels sluggish
        debounce = 50,
    },
    markdown = {
        headings    = { enable = true },
        code_blocks = { enable = true },
        tables      = { enable = true },
        list_items  = { enable = true },
        block_quotes = { enable = true },
    },
    latex = {
        -- Disable if you don't write LaTeX math; saves overhead
        enable = false,
    },
})

local o = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>mv', '<cmd>Markview Toggle<CR>',       vim.tbl_extend('force', o, { desc = 'markdown: toggle preview' }))
vim.keymap.set('n', '<Leader>mh', '<cmd>Markview HybridToggle<CR>', vim.tbl_extend('force', o, { desc = 'markdown: toggle hybrid mode' }))
vim.keymap.set('n', '<Leader>ms', '<cmd>Markview splitToggle<CR>',  vim.tbl_extend('force', o, { desc = 'markdown: toggle split view' }))
