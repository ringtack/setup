-- Keymap <leader>so defined in plugins.lua keys spec (registered at startup, not on plugin load).

require("outline").setup({
    outline_window = {
        width = 20,
        show_numbers = true,
        show_relative_numbers = true,
        -- Auto-focus the outline when opened; use <C-H> to return to code buffer.
        focus_on_open = true,
    },
})
