-- nvim-notify needs a background colour when the colorscheme doesn't define
-- NotifyBackground, otherwise it emits a "no background highlight" warning.
require("notify").setup({
    background_colour = "#000000",
})

require("noice").setup({
    routes = {
        { -- shell command output shown as a noice notification
            filter = { event = "msg_show", kind = "shell_out" },
            view = "notify",
        },
        { -- hide "" messages (see "A Guide To Messages" in the Noice wiki for more)
            filter = {
                event = "msg_show",
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
    },
    lsp = {
        signature = {
            enabled = true,
        },
        -- override markdown rendering so plugins use Treesitter
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
        },
    },
    popupmenu = {
        enabled = true,
        backend = "nui",
    },
    cmdline = {
        -- view = "cmdline",
    },
    -- you can enable a preset for easier configuration
    presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
})
