---- NVIM-TREESITTER (new main-branch API, nvim 0.11+) ----
-- setup() only accepts install_dir; highlight/indent/selection are not configured here.
-- Parsers are installed via require('nvim-treesitter').install({...}).
-- Highlighting and indentation are enabled via FileType autocommands below.

local parsers = {
    "bash", "c", "cpp", "css", "dockerfile", "go", "gomod", "glsl",
    "html", "javascript", "json", "latex", "lua", "make",
    "markdown", "markdown_inline", "proto", "python", "regex",
    "rust", "typescript", "toml", "yaml",
}

-- nvim-treesitter healthcheck compares install_dir with a trailing slash (via vim.fs.joinpath)
-- against nvim_list_runtime_paths() which strips trailing slashes. Prepend the trailing-slash
-- variant so the healthcheck finds it. stdpath('data')/site is already in rtp by default.
vim.opt.rtp:prepend(vim.fn.stdpath('data') .. '/site/')

-- Install parsers if not already present (runs asynchronously, no-op if installed).
require('nvim-treesitter').install(parsers)

-- Enable treesitter highlighting and indentation for the languages we care about.
-- Map parser names to filetypes (most are 1:1; exceptions listed here).
local ft_to_parser = {
    bash       = 'sh',
    c          = 'c',
    cpp        = 'cpp',
    css        = 'css',
    dockerfile = 'dockerfile',
    go         = 'go',
    gomod      = 'gomod',
    glsl       = 'glsl',
    html       = 'html',
    javascript = 'javascript',
    json       = 'json',
    latex      = 'tex',
    lua        = 'lua',
    make       = 'make',
    markdown   = 'markdown',
    python     = 'python',
    proto      = 'proto',
    regex      = 'regex', -- rarely used standalone; here for completeness
    rust       = 'rust',
    typescript = 'typescript',
    toml       = 'toml',
    yaml       = 'yaml',
}

local filetypes = vim.tbl_values(ft_to_parser)

vim.api.nvim_create_autocmd('FileType', {
    pattern = filetypes,
    callback = function()
        -- Treesitter highlighting (replaces Vim regex syntax)
        local ok, err = pcall(vim.treesitter.start)
        if not ok then
            vim.notify('treesitter.start failed: ' .. tostring(err), vim.log.levels.WARN)
        end
        -- Treesitter-based indentation (experimental but useful)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})


---- NVIM-TREESITTER-TEXTOBJECTS ----
-- The textobjects plugin has its own setup + keymaps are set manually.

require('nvim-treesitter-textobjects').setup({
    select = {
        lookahead = true,
    },
    move = {
        set_jumps = true,
    },
})

local sel = require('nvim-treesitter-textobjects.select')
local mov = require('nvim-treesitter-textobjects.move')
local swp = require('nvim-treesitter-textobjects.swap')

-- Text object selections (visual + operator-pending modes)
local select_maps = {
    ['af'] = { '@function.outer',  'ts: outer function' },
    ['if'] = { '@function.inner',  'ts: inner function' },
    ['ac'] = { '@class.outer',     'ts: outer class' },
    ['ic'] = { '@class.inner',     'ts: inner class' },
    ['al'] = { '@loop.outer',      'ts: outer loop' },
    ['il'] = { '@loop.inner',      'ts: inner loop' },
    ['ab'] = { '@block.outer',     'ts: outer block' },
    ['ib'] = { '@block.inner',     'ts: inner block' },
    ['ar'] = { '@parameter.outer', 'ts: outer parameter' },
    ['ir'] = { '@parameter.inner', 'ts: inner parameter' },
}
for key, v in pairs(select_maps) do
    local q, desc = v[1], v[2]
    vim.keymap.set({ 'x', 'o' }, key, function()
        sel.select_textobject(q, 'textobjects')
    end, { desc = desc })
end

-- Swap next/previous parameter
vim.keymap.set('n', '<leader>a', function() swp.swap_next('@parameter.inner') end,     { desc = 'ts: swap next parameter' })
vim.keymap.set('n', '<leader>A', function() swp.swap_previous('@parameter.inner') end, { desc = 'ts: swap previous parameter' })

-- Movement: next start
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() mov.goto_next_start('@function.outer', 'textobjects') end, { desc = 'ts: next function start' })
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() mov.goto_next_start('@class.outer', 'textobjects') end,    { desc = 'ts: next class start' })

-- Movement: next end
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() mov.goto_next_end('@function.outer', 'textobjects') end, { desc = 'ts: next function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() mov.goto_next_end('@class.outer', 'textobjects') end,    { desc = 'ts: next class end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']l', function() mov.goto_next_end('@loop.outer', 'textobjects') end,     { desc = 'ts: next loop end' })
vim.keymap.set({ 'n', 'x', 'o' }, ']b', function() mov.goto_next_end('@block.outer', 'textobjects') end,    { desc = 'ts: next block end' })

-- Movement: previous start
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() mov.goto_previous_start('@function.outer', 'textobjects') end, { desc = 'ts: prev function start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() mov.goto_previous_start('@class.outer', 'textobjects') end,    { desc = 'ts: prev class start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[l', function() mov.goto_previous_start('@loop.outer', 'textobjects') end,     { desc = 'ts: prev loop start' })
vim.keymap.set({ 'n', 'x', 'o' }, '[b', function() mov.goto_previous_start('@block.outer', 'textobjects') end,    { desc = 'ts: prev block start' })

-- Movement: previous end
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() mov.goto_previous_end('@function.outer', 'textobjects') end, { desc = 'ts: prev function end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() mov.goto_previous_end('@class.outer', 'textobjects') end,    { desc = 'ts: prev class end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[L', function() mov.goto_previous_end('@loop.outer', 'textobjects') end,     { desc = 'ts: prev loop end' })
vim.keymap.set({ 'n', 'x', 'o' }, '[B', function() mov.goto_previous_end('@block.outer', 'textobjects') end,    { desc = 'ts: prev block end' })


---- TREESITTER-CONTEXT ----
require('treesitter-context').setup({
    enable = true,
    max_lines = 3,
    zindex = 100,
    separator = '-',
})
