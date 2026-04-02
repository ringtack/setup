require("toggleterm").setup({
    open_mapping = '<c-t>',
    direction = 'float',
    float_opts = {
        border = 'curved',
        width = function() return vim.o.columns * 0.75 end,
    },
    winbar = {
        enabled = true,
    }
})

local o = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>tl", "<cmd>ToggleTermSendCurrentLine<CR>",      vim.tbl_extend('force', o, { desc = 'term: send current line' }))
vim.keymap.set("v", "<leader>tv", "<cmd>ToggleTermSendVisualSelection<CR>",  vim.tbl_extend('force', o, { desc = 'term: send visual selection' }))

-- GitUI floating terminal
local Terminal = require('toggleterm.terminal').Terminal
local gitui = Terminal:new({
    cmd = "gitui",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "curved",
        width = function() return vim.o.columns * 0.75 end,
    },
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", o)
    end,
    on_close = function()
        vim.cmd("startinsert!")
    end,
})

vim.keymap.set("", "<leader>gs", function() gitui:toggle() end,
    vim.tbl_extend('force', o, { desc = 'git: open gitui' }))
