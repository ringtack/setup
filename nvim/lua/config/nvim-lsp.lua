-- Set up mason for LSP server installation.
-- automatic_enable (default true) calls vim.lsp.enable() for every installed server.
-- Exclude rust_analyzer because rustaceanvim manages it instead.
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        'asm_lsp', -- Assembly
        'bashls', -- Bash
        'clangd', -- C/C++
        'dockerls', -- Docker
        'eslint', -- JS[X], TS[X], Vue
        'gopls', -- Go
        'jedi_language_server', -- Python
        'lua_ls', -- Lua
        'pyright', -- Python
        'rust_analyzer', -- Rust (installed by mason, started by rustaceanvim)
        'ts_ls', -- JS[X], TS[X]
    },
    automatic_enable = {
        exclude = { 'rust_analyzer' }, -- rustaceanvim owns this one
    },
})


---- DIAGNOSTICS CONFIG

vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.WARN },
    },
    underline = true,
    -- Use new nvim 0.10+ signs API (avoids deprecated sign_define)
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✗",
            [vim.diagnostic.severity.WARN]  = "⚠",
            [vim.diagnostic.severity.HINT]  = "",
            [vim.diagnostic.severity.INFO]  = "",
        },
    },
    float = {
        border = "rounded",
        focus = false,
        show_header = false,
        source = "if_many",
    },
    update_in_insert = false,
    severity_sort = true,
})

vim.api.nvim_set_hl(0, 'FloatBorder', { fg = 'DarkGray' })

vim.o.updatetime = 200

-- Show diagnostics in a pop-up window on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
    buffer = 0,
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        })
    end
})

vim.o.signcolumn = "number"


---- NATIVE LSP CONFIG (nvim 0.11+) ----

local capabilities = require("blink.cmp").get_lsp_capabilities()

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

-- Global defaults applied to every server
vim.lsp.config('*', {
    capabilities = capabilities,
    handlers = handlers,
    flags = { debounce_text_changes = 150 },
})

-- clangd: needs utf-16 offsetEncoding to suppress the mismatch warning
vim.lsp.config('clangd', {
    capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = { "utf-16" } }),
})

-- lua_ls: suppress "vim/use/require is undefined global" warnings in config files
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim', 'use', 'require' } }
        }
    }
})


---- LSP ATTACH — keymaps and signature, applied to every attached LSP ----

local lsp_signature_opts = {
    bind = true,
    floating_window = true,
    floating_window_above_cur_line = true,
    transparency = 20,
    handler_opts = { border = "rounded" },
    doc_lines = 2,
    zindex = 50,
    fix_pos = false,
    toggle_key = '<A-x>',
}

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        require('lsp_signature').on_attach(lsp_signature_opts, bufnr)

        local o = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<C-]>',      vim.lsp.buf.definition,          vim.tbl_extend('force', o, { desc = 'LSP: go to definition' }))
        vim.keymap.set('n', 'K',          vim.lsp.buf.hover,               vim.tbl_extend('force', o, { desc = 'LSP: hover docs' }))
        vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation,      vim.tbl_extend('force', o, { desc = 'LSP: go to implementation' }))
        vim.keymap.set('n', '<Leader>D',  vim.lsp.buf.type_definition,     vim.tbl_extend('force', o, { desc = 'LSP: go to type definition' }))
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename,              vim.tbl_extend('force', o, { desc = 'LSP: rename symbol' }))
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action,         vim.tbl_extend('force', o, { desc = 'LSP: code action' }))
        vim.keymap.set('n', '<Leader>f',  function() vim.lsp.buf.format({ async = true }) end,
                                                                            vim.tbl_extend('force', o, { desc = 'LSP: format buffer' }))
        vim.keymap.set('n', '<Leader>ih', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end,                                                                vim.tbl_extend('force', o, { desc = 'LSP: toggle inlay hints' }))
        -- NOTE: <Leader>lr instead of <Leader>gr / gr:
        -- nvim 0.11 installs buffer-local keymaps grr/grn/gra/gri in every LspAttach handler,
        -- AFTER our own handler runs.  That means any `gr*` keymap we set here gets clobbered,
        -- and even a plain `gr` mapping causes a `timeoutlen` ambiguity because nvim now waits
        -- to see whether `grr` follows.  Using <Leader>lr avoids the entire `gr` namespace.
        vim.keymap.set('n', '<Leader>lr', function()
            require('telescope.builtin').lsp_references({ jump_type = "never" })
        end,                                                                vim.tbl_extend('force', o, { desc = 'LSP: references' }))
        vim.keymap.set('n', '<Leader>k',  function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end,
                                                                            vim.tbl_extend('force', o, { desc = 'diagnostic: previous' }))
        vim.keymap.set('n', '<Leader>j',  function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end,
                                                                            vim.tbl_extend('force', o, { desc = 'diagnostic: next' }))
        vim.keymap.set('n', '<space>wa',  vim.lsp.buf.add_workspace_folder,    vim.tbl_extend('force', o, { desc = 'LSP: add workspace folder' }))
        vim.keymap.set('n', '<space>wr',  vim.lsp.buf.remove_workspace_folder, vim.tbl_extend('force', o, { desc = 'LSP: remove workspace folder' }))
        vim.keymap.set('n', '<space>wl',  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                                                                            vim.tbl_extend('force', o, { desc = 'LSP: list workspace folders' }))

        -- Clangd-specific keymaps
        if client and client.name == "clangd" then
            vim.keymap.set('n', '<Leader>sh', '<cmd>ClangdSwitchSourceHeader<CR>', vim.tbl_extend('force', o, { desc = 'clangd: switch source/header' }))
            vim.keymap.set('n', '<Leader>th', '<cmd>ClangdTypeHierarchy<CR>',      vim.tbl_extend('force', o, { desc = 'clangd: type hierarchy' }))
        end
    end
})


---- CLANGD EXTENSIONS ----
-- setup() here only controls UI options (ast view, inlay hints highlighting).
-- The clangd server itself is started by mason-lspconfig's automatic_enable,
-- with capabilities set via vim.lsp.config('clangd', ...) above.
require("clangd_extensions").setup({
    extensions = {
        inlay_hints = {
            highlight = 'Conceal',
        },
        ast = {
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },
            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            },
        }
    }
})
