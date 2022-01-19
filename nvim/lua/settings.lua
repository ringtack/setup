---- GENERAL SECTION ----


-- shorten some commands
local o = vim.o
local wo = vim.wo
local cmd = vim.cmd
local nvim_exec = vim.api.nvim_exec


-- enable clicking and scrolling as expected
o.mouse = 'a'

-- set number of visual spaces per tab
o.tabstop = 4
o.shiftwidth = 4
-- don't convert tabs to space
o.expandtab = true

-- show relative line number
o.number = true
o.relativenumber = true
-- set line number colors to black
cmd('hi LineNr ctermfg=darkgray')

-- case-insensitive searching unless something is capitalized
o.ignorecase = true
o.smartcase = true

-- automatic C program indenting
o.smartindent = true

-- Enable softwrapping, and hardwrapping at 100
o.linebreak = true
o.textwidth = 100
-- create vertical line at 100
o.colorcolumn = '100'
cmd('hi ColorColumn ctermbg=darkgray')

-- highlight current cursor line
o.cursorline = true
o.cursorlineopt = 'screenline,number'

-- enable termguicolors for NvimTree
vim.cmd('set termguicolors')
-- set colorscheme to OneDark
vim.cmd('colorscheme onedark')




--- shopkeeping stuff

-- redraw only when necessary (not in the middle of macros)
-- o.lazyredraw = true

-- allow hiding buffers with unsaved changes
o.hidden = true

-- prevent shell scripts from executing
o.secure = true
