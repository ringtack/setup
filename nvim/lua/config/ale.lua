local cmd = vim.cmd
local g = vim.g
local o = vim.o
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap




---- LINTING CONFIGURATION ----
--- EXPERIMENTAL: Figure out integration with nvim-lspconfig; currently I just disable
-- Customize linting symbols
g.ale_sign_error = ''
g.ale_sign_warning = '' -- Warning symbol (U+26A0) ⚠
g.ale_sign_info = ''

-- Enable virtual text
g.ale_virtualtext_cursor = 0
g.ale_virtualtext_prefix = '\t '
-- combine sign gutter and line number into one
o.signcolumn = "number"


-- Navigate to errors
-- map('n', '<Leader>j', ':ALENextWrap<CR>', {})
-- map('n', '<Leader>k', ':ALEPreviousWrap<CR>', {})


-- Customize highlights
-- cmd([[
-- hi ALEError gui=underline guibg=NONE guifg=#e86671
-- hi ALEWarning gui=underline guibg=NONE guifg=#e5c07b
-- hi ALEVirtualTextError gui=NONE guibg=NONE guifg=#e86671
-- hi ALEVirtualTextWarning gui=NONE guibg=NONE guifg=#e5c07b
-- ]])


-- configure linters per language
-- g.ale_linters = {
    -- rust = {'rustc', 'rls'},
    -- tex = {'chktex', 'lacheck'},
    -- -- TODO: pyright vs. pylint vs flake8
    -- python = {'pyright', 'pylint', 'flake8'},
    -- -- uses default C++ compiler (usually clang++)
    -- cpp = {'cc'}
-- }
-- disable linters?
g.ale_linters = {
    cpp = {},
    javascript = {},
    python = {},
    rust = {},
    tex = {},
}



-- Set clang++ options
-- g.ale_cpp_cc_options = '-Wall -O2 -std=c++17'



---- FIXING CONFIGURATION ----
-- fix on save
g.ale_fix_on_save = 1

-- configure fixers per language
g.ale_fixers = {
    javascript = {'prettier', 'eslint'},
    javascriptreact = {'prettier', 'eslint'},
    typescript = {'prettier', 'eslint'},
    typescriptreact = {'prettier', 'eslint'},
    json = {'prettier'},
    c = {'clang-format'},
    cpp = {'clang-format'},
    rust  = {'rustfmt'},
    go = {'gofmt'},
    python = {'isort', 'black', 'autopep8'},
    tex = {'latexindent'},
    markdown = {'pandoc'}
}




---- MISC CONFIGURATION ----


-- shortcut for ALEFix
map('n', '<Leader>p', ':ALEFix<CR>', {})
