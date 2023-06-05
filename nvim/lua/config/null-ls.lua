local nls = require("null-ls")



local sources = {
    ---- FORMATTING

    -- Python
    -- null_ls.builtins.formatting.autopep8,     -- python
    nls.builtins.formatting.black, -- python
    nls.builtins.formatting.isort, -- python

    -- C/C++
    nls.builtins.formatting.clang_format.with({
        extra_args = { "-style=file" }
    }), -- c, cpp, cs, java

    -- Golang
    nls.builtins.formatting.gofmt, -- go
    nls.builtins.formatting.goimports, -- go
    nls.builtins.formatting.golines, -- go

    -- Rust
    nls.builtins.formatting.rustfmt, -- rust

    -- JavaScript/TypeScript
    nls.builtins.formatting.eslint_d, -- js, jsx, ts, tsx, vue
    nls.builtins.formatting.prettierd, -- js[x], ts[x], vue, [s]css, html, json, yaml, md, graphql


    ---- LINTING

    -- C/C++
    nls.builtins.diagnostics.cppcheck.with({ -- c, cpp
        args = { "--std=c++20", "--language=c++" },
    }),
    nls.builtins.diagnostics.cpplint.with({ -- cpp
        disabled_filetypes = { "c" },
    }),

    -- Golang
    -- null_ls.builtins.diagnostics.staticcheck, -- go

    -- Markdown
    nls.builtins.diagnostics.markdownlint.with({ -- markdown
        extra_args = { "-r", "~/.markdownlint.yaml" },
    }),

    -- and TeX
    -- null_ls.builtins.diagnostics.proselint,   -- markdown, tex
    -- null_ls.builtins.diagnostics.write_good,  -- markdown, tex

    -- Bash
    nls.builtins.diagnostics.shellcheck,


    ---- Miscellaneous

    -- Gitsigns actions
    nls.builtins.code_actions.gitsigns,
}



---- Formatting on save
-- Here, only use null-ls for formatting
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            -- print(client.name)
            return client.name == "null-ls"
        end
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
                -- TODO: figure out why null ls is shitting itself on format-on-save
                -- lsp_formatting(bufnr)

                vim.lsp.buf.format({ bufnr = bufnr })
            end,
        })
    end
end

nls.setup({
    sources = sources,
    -- format on save
    on_attach = on_attach,
})
