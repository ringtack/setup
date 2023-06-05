require('go').setup()

-- TODO: make these programmatic (currently, I manually updated go.vim lolol)
-- local g = vim.g
-- local cmd = vim.cmd

-- g.go_highlight_extra_types = 1
-- g.go_highlight_operators = 1
-- g.go_highlight_functions = 1
-- g.go_highlight_function_calls = 1
-- g.go_highlight_types = 1
-- g.go_highlight_fields = 1
-- g.go_highlight_variable_declarations = 1
-- g.go_highlight_variable_assignments = 1

-- Wtf are these defaults lmfao (ok should be fixed in go.nvim/syntax/go.vim)
-- cmd('hi link goBuiltins Special') -- Originally Identifier
-- cmd('hi link goFunctionCall Function') -- Originally Type
-- cmd('hi link goField Type') -- Originally Identifier??
