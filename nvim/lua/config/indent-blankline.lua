vim.cmd('hi IndentBlanklineContextChar guifg=lightgray')

require("indent_blankline").setup {
    -- use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false,
}
