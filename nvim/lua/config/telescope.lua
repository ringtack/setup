-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap

-- shortcuts for common Telescope features
local opts = { noremap = true, silent = true }
map('n', '<leader>lg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>ff', ':Telescope find_files<CR>', opts)
map('n', '<leader>fb', ':Telescope buffers<CR>', opts)
map('n', '<leader>ft', ':TodoTelescope<CR>', opts)
map('n', '<leader>tn', ':Telescope noice<CR>', opts)


local telescope = require('telescope')
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
    defaults = {
        layout_config = {
            horizontal = {
                preview_width = 0.6, -- available only for layout_config; see :help telescope.layout
            },
        },
        -- in general, don't follow .gitignore, but don't want these still
        file_ignore_patterns = { "node_modules", ".git", ".terraform", "%.jpg", "%.png", '.rustup' },
        -- used for grep_string and live_grep
        vimgrep_arguments = {
            "rg",
            "--follow",
            "--color=never",   -- don't want colors in Telescope prompt
            "--no-heading",    -- headings suck with Telescope
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--no-ignore",
            "--trim",
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            sort_lastused = true,
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case" or "smart_case"
        },
        file_browser = {
            mappings = {
                i = { -- insert mode mappings
                    ["<C-n>"] = fb_actions.create,
                    ["<C-r>"] = fb_actions.rename,
                    ["<C-d>"] = fb_actions.remove,
                }
            }
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown { }
        },
    }
})

telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('ui-select')
telescope.load_extension("noice")

-- Modify live-grep directory: https://github.com/nvim-telescope/telescope.nvim/issues/2201
-- TODO: figure this shit out later
