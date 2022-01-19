require('lualine').setup{
    options = {
        theme = 'onedark-nvim',
        component_separators = '|',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 
            { 'diff', separator = { right = '' }, left_padding = 2 },
        },
        lualine_x = {'diagnostics'},
        lualine_y = { 'fileformat', 'filetype', 'progress' },
        lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
        },
  },
  inactive_sections = {},
    -- inactive_sections = {
        -- -- lualine_a = { 'filename' },
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = { 'location' },
    -- },
    tabline = {},
    extensions = {},
}
