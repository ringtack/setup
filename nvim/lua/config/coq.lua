local g = vim.g

-- autostart coq
g.coq_settings = {
    auto_start = 'shut-up',
    -- limits = {
        -- completion_auto_timeout = 0.2,
    -- },
    display = {
        pum = {
            x_max_len = 44, -- make suggestions window smaller
            x_truncate_len = 16, -- fix weird brackets
        },
        preview = {
            x_max_len = 66, -- make preview window smaller
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
        tree_sitter = {
            -- weight_adjust = 0.35, -- prioritize TreeSitter a little more
            path_sep = "", -- I don't like the symbol
        },
        tags = {
            weight_adjust = 0.4, -- prioritize tags the most; most informative
        },
    },
}
