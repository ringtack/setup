require("toggleterm").setup({
    open_mapping = '<c-t>', -- <c-t> to open
    direction = 'float',
    float_opts = {
        border = 'curved',
        width = function() return vim.o.columns * 0.75 end,
    },
    winbar = {
        enabled = true,
    }
})

-- Maps to send current line/visual selection to toggleterm
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>tl", "<cmd>ToggleTermSendCurrentLine<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>tv", "<cmd>ToggleTermSendVisualSelection<CR>", opts)

-- GitUI support
local Terminal = require('toggleterm.terminal').Terminal
local gitui = Terminal:new({
    cmd = "gitui",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "curved",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
    end,
    -- function to run on closing the terminal
    on_close = function(term)
        vim.cmd("startinsert!")
    end,
})

local gitui_toggle = function()
    gitui:toggle()
end

vim.keymap.set("", "<leader>gs", gitui_toggle, opts)
