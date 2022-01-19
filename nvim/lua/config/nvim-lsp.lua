local lsp = require('lspconfig')
-- local coq = require('coq')

---- ENABLE LANGUAGE SERVERS ----
-- lsp.clangd.setup(coq.lsp_ensure_capabilities({}))
lsp.clangd.setup({})
