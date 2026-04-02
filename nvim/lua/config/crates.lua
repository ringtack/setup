require("crates").setup({
    null_ls = { enabled = true, name = "Crates" },
    lsp = { enabled = true, actions = true, completion = true, hover = true },
})
