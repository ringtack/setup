local null_ls = require("null-ls")



local sources = {
  ---- FORMATTING

  -- Python
  null_ls.builtins.formatting.autopep8,
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.isort,

  -- C/C++
  null_ls.builtins.formatting.clang_format,

  -- Golang
  null_ls.builtins.formatting.gofmt,
  null_ls.builtins.formatting.goimports,
  null_ls.builtins.formatting.golines,

  -- Rust
  null_ls.builtins.formatting.rustfmt,

  -- JavaScript/TypeScript
  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.formatting.prettierd,




  ---- LINTING

  -- C/C++
  null_ls.builtins.diagnostics.cppcheck,

  -- Golang
  null_ls.builtins.diagnostics.staticcheck,

  -- Markdown
  null_ls.builtins.diagnostics.markdownlint,
  -- and TeX
  null_ls.builtins.diagnostics.proselint,
  null_ls.builtins.diagnostics.write_good,
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
