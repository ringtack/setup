local g = vim.g
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

-- Helpful key re-maps for Coq
map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- autostart coq
g.coq_settings = {
    auto_start = 'shut-up',
    -- limits = {
        -- completion_auto_timeout = 0.2,
    -- },
    display = {
        pum = {
            x_max_len = 50, -- make suggestions window smaller
            x_truncate_len = 16, -- fix weird brackets
        },
        preview = {
            x_max_len = 60, -- make preview window smaller
            resolve_timeout = 0.88,
            positions = {
                north = 2,
                south = 3,
                east = 1,
                west = 4,
            }
        },
        icons = {
            mode = "short",
        },
    },
    -- clients = {
        -- snippets = {
            -- warn = {},
        -- },
        -- tree_sitter = {
            -- weight_adjust = 0.35, -- prioritize TreeSitter a little more
            -- path_sep = "", -- I don't like the symbol
        -- },
        -- tags = {
            -- weight_adjust = 0.4, -- prioritize tags the most; most informative
        -- },
    -- },
    -- disable keymaps that mess w/ window navigation
    keymap = {
        jump_to_mark = "<c-s>",
        bigger_preview = "",
        manual_complete = "",
        recommended = false,
    },
}

vim.cmd [[ autocmd VimEnter * ++nested COQnow -s ]]
vim.cmd [[ ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>" ]]
