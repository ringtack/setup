local g = vim.g

vim.cmd [[ autocmd VimEnter * ++nested COQnow -s ]]
vim.cmd [[ ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>" ]]

-- autostart coq
g.coq_settings = {
    auto_start = true,
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
    clients = {
        snippets = {
            warn = {}, 
        },
        -- tree_sitter = {
            -- weight_adjust = 0.35, -- prioritize TreeSitter a little more
            -- path_sep = "", -- I don't like the symbol
        -- },
        tags = {
            weight_adjust = 0.4, -- prioritize tags the most; most informative
        },
    },
}
