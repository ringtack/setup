---- GENERAL SECTION ----

local o = vim.o

-- enable clicking and scrolling as expected
o.mouse = 'a'

-- set number of visual spaces per tab
o.tabstop    = 4
o.shiftwidth = 4
o.expandtab  = true

-- show relative line number
o.number         = true
o.relativenumber = true

-- case-insensitive searching unless something is capitalized
o.ignorecase = true
o.smartcase  = true

-- automatic C program indenting
o.smartindent = true

-- softwrapping + hard wrap at 100 columns
o.linebreak   = true
o.textwidth   = 100
o.colorcolumn = '100'

-- highlight current cursor line
o.cursorline    = true
o.cursorlineopt = 'screenline,number'

-- enable true-color
o.termguicolors = true

-- change search highlight to something readable
vim.api.nvim_set_hl(0, 'Search', { fg = 'bg', bg = 'Gray' })

-- allow hiding buffers with unsaved changes
o.hidden = true

-- prevent shell scripts from executing (modeline exploits etc.)
o.secure = true

-- disable unused built-in plugins to reclaim startup time
vim.g.loaded_matchit = 1  -- ~1.8ms; matchit.vim not needed alongside treesitter textobjects
