local null_ls = require("null-ls")



local sources = {
    ---- FORMATTING

    -- Python
    -- null_ls.builtins.formatting.autopep8,     -- python
    null_ls.builtins.formatting.black,        -- python
    null_ls.builtins.formatting.isort,        -- python

    -- C/C++
    null_ls.builtins.formatting.clang_format.with({
        extra_args = {"-style=file"}
    }), -- c, cpp, cs, java

    -- Golang
    null_ls.builtins.formatting.gofmt,        -- go
    null_ls.builtins.formatting.goimports,    -- go
    null_ls.builtins.formatting.golines,      -- go

    -- Rust
    null_ls.builtins.formatting.rustfmt,      -- rust

    -- JavaScript/TypeScript
    null_ls.builtins.formatting.eslint_d,     -- js, jsx, ts, tsx, vue
    null_ls.builtins.formatting.prettierd,    -- js, jsx, ts, tsx, vue, [s]css, less, html, json,
    -- yaml, markdown, graphql


    ---- LINTING

    -- C/C++
    null_ls.builtins.diagnostics.cppcheck.with({    -- c, cpp
        args = {"--std=c++20", "--language=c++"},
    }),
    null_ls.builtins.diagnostics.cpplint.with({    -- cpp
        disabled_filetypes = {"c"},
    }),

    -- Golang
    null_ls.builtins.diagnostics.staticcheck, -- go

    -- Markdown
    null_ls.builtins.diagnostics.markdownlint.with({  -- markdown
        extra_args = {"-r", "~/.markdownlint.yaml"},
    }),

    -- and TeX
    -- null_ls.builtins.diagnostics.proselint,   -- markdown, tex
    -- null_ls.builtins.diagnostics.write_good,  -- markdown, tex

    -- Bash
    null_ls.builtins.diagnostics.shellcheck,
}



---- Formatting on save
-- Here, only use null-ls for formatting
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

null_ls.setup({
    sources = sources,
    -- format on save
    on_attach = on_attach,
})
