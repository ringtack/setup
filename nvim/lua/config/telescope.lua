local o = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>lg', ':Telescope live_grep<CR>',   vim.tbl_extend('force', o, { desc = 'telescope: live grep' }))
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>',  vim.tbl_extend('force', o, { desc = 'telescope: find files' }))
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>',     vim.tbl_extend('force', o, { desc = 'telescope: list buffers' }))
vim.keymap.set('n', '<leader>ft', ':TodoTelescope<CR>',         vim.tbl_extend('force', o, { desc = 'telescope: search TODOs' }))
vim.keymap.set('n', '<leader>tn', ':Telescope noice<CR>',       vim.tbl_extend('force', o, { desc = 'telescope: browse notifications' }))


-- File extensions that should open in the system default app instead of nvim.
local system_open_exts = {
    png=true, jpg=true, jpeg=true, gif=true, svg=true, webp=true,
    pdf=true, mp4=true, mov=true, mp3=true,
}

local actions      = require('telescope.actions')
local action_state = require('telescope.actions.state')

--- Opens the selected entry in nvim, or via macOS `open` for binary/media files.
local function smart_open(prompt_bufnr)
    local entry    = action_state.get_selected_entry()
    local filepath = entry and (entry.path or entry.filename)
    if not filepath then return end
    local ext = vim.fn.fnamemodify(filepath, ':e'):lower()
    actions.close(prompt_bufnr)
    if system_open_exts[ext] then
        vim.fn.jobstart({ 'open', filepath }, { detach = true })
    else
        vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
        -- Jump to the matched line/col for grep results (entry.lnum is 1-based, col is 1-based)
        if entry.lnum then
            vim.api.nvim_win_set_cursor(0, { entry.lnum, (entry.col or 1) - 1 })
        end
    end
end

local telescope = require('telescope')
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
    defaults = {
        mappings = {
            i = { ["<CR>"] = smart_open },
            n = { ["<CR>"] = smart_open },
        },
        layout_config = {
            horizontal = {
                preview_width = 0.6,
            },
        },
        file_ignore_patterns = { "node_modules", ".git", ".terraform", ".rustup" },
        vimgrep_arguments = {
            "rg",
            "--follow",
            "--color=never",
            "--no-heading",
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
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        file_browser = {
            mappings = {
                i = {
                    ["<C-n>"] = fb_actions.create,
                    ["<C-r>"] = fb_actions.rename,
                    ["<C-d>"] = fb_actions.remove,
                }
            }
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        },
    }
})

-- Defer extension loading until after startup completes (~15ms savings).
-- VeryLazy fires before the user can interact, so extensions are available on first use.
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    once = true,
    callback = function()
        telescope.load_extension('fzf')
        telescope.load_extension('file_browser')
        telescope.load_extension('ui-select')
        telescope.load_extension("noice")
    end,
})
