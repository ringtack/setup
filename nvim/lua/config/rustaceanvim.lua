-- vim.g.rustaceanvim can be a function that returns the config table.
-- Using a function defers evaluation until a Rust file is first opened,
-- guaranteeing blink.cmp (and all other plugins) are fully loaded so that
-- get_lsp_capabilities() returns a proper table (not a wrapped closure).
-- rustaceanvim's LSP code calls vim.tbl_get(server_cfg.capabilities, ...) and
-- requires capabilities to be a table — a function value silently breaks it.
vim.g.rustaceanvim = function()
    return {
        tools = {
            inlay_hints = {
                -- highlight group is set in color.lua via LspInlayHint
            },
            hover_actions = {
                auto_focus = false,
            },
        },

        server = {
            -- Must be a table, not a function. Evaluated here (lazily) so
            -- blink.cmp is guaranteed to be loaded at this point.
            capabilities = require("blink.cmp").get_lsp_capabilities(),

            on_attach = function(client, bufnr)
                -- Standard keymaps (definition, hover, rename, etc.) are set by
                -- the global LspAttach autocmd in nvim-lsp.lua for all clients.
                -- Only Rust-specific commands are needed here.
                local o = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', '<Leader>em', '<cmd>RustLsp expandMacro<CR>',  vim.tbl_extend('force', o, { desc = 'rust: expand macro' }))
                vim.keymap.set('n', '<Leader>mu', '<cmd>RustLsp moveItem up<CR>',   vim.tbl_extend('force', o, { desc = 'rust: move item up' }))
                vim.keymap.set('n', '<Leader>md', '<cmd>RustLsp moveItem down<CR>', vim.tbl_extend('force', o, { desc = 'rust: move item down' }))
                vim.keymap.set('n', '<Leader>oc', '<cmd>RustLsp openCargo<CR>',     vim.tbl_extend('force', o, { desc = 'rust: open Cargo.toml' }))
            end,

            settings = {
                ["rust-analyzer"] = {
                    assist = {
                        importGranularity = "module",
                        importPrefix = "by_self",
                    },
                    cargo = {
                        buildScripts = { enable = true },
                    },
                    procMacro = {
                        enable = true,
                    },
                    checkOnSave = {
                        command = "clippy",
                    },
                },
            },
        },

        dap = {},
    }
end
