require("blink.cmp").setup({
    keymap = {
        preset = "default",
        -- signature jump (was coq's jump_to_mark)
        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        -- Tab/Enter for cycling and accepting completions
        ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"]    = { "accept", "fallback" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },

    snippets = {
        -- "default" uses nvim's built-in vim.snippet; no external plugin needed.
        -- friendly-snippets (listed as a blink.cmp dependency) provides the
        -- VS Code snippet corpus that the "snippets" source serves.
        preset = "default",
    },

    completion = {
        menu = {
            -- NOTE: completion.menu has no max_width field (only min_width/max_height).
            min_width = 15,
            max_height = 10,
        },
        documentation = {
            auto_show = true,
            window = {
                border = "rounded",
                max_width = 60,
            },
        },
    },

    signature = {
        enabled = true,
        window = {
            border = "rounded",
        },
    },
})
