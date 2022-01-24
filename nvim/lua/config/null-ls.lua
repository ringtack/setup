local null_ls = require("null-ls")



local sources = {
  ---- FORMATTING

  -- Python
  -- null_ls.builtins.formatting.autopep8,     -- python
  null_ls.builtins.formatting.black,        -- python
  null_ls.builtins.formatting.isort,        -- python

  -- C/C++
  null_ls.builtins.formatting.clang_format, -- c, cpp, cs, java

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
  null_ls.builtins.diagnostics.cppcheck,    -- c, cpp

  -- Golang
  null_ls.builtins.diagnostics.staticcheck, -- go

  -- Markdown
  null_ls.builtins.diagnostics.markdownlint,-- markdown
  -- and TeX
  null_ls.builtins.diagnostics.proselint,   -- markdown, tex
  null_ls.builtins.diagnostics.write_good,  -- markdown, tex
}



null_ls.setup({
  sources = sources,
  -- format on save
  on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
            augroup END
            ]])
        end
  end,
})
