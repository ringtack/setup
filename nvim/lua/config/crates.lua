local null_ls = require('null-ls')

require('crates').setup({
    -- TODO: fix later when I care enough
    null_ls = {
        enabled = true,
        name = "Crates",
    },
    src = {
        coq = {
            enabled = true,
            name = "Crates",
        },
    },
})
