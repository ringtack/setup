---- PLUGINS SECTION ---- We use Packer as our package manager.

-- shorten some commands
local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt

-- Automatically install Packer if not already 
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- manually set python executable for faster load times
-- see https://www.redd.it/r9acxp/
vim.g.python3_host_prog = fn.expand('~/.pyenv/shims/python')

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Run :PackerCompile whenever a configuration is changed
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

-- install packages
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    

    ---- UTILITIES
    -- surround highlighted text
    use 'tpope/vim-surround'

    -- autopairs
    use { 'windwp/nvim-autopairs', config = [[require('config.autopairs')]] }

    -- easier commenting
    use { 'preservim/nerdcommenter', config = [[require('config.nerdcommenter')]] }

    -- enable treesitter support for better syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = [[require('config.nvim-tree')]],
    }

    -- tag generation (navigate definitions with Ctrl-[])
    use 'ludovicchabant/vim-gutentags'
    
    -- easily replace word variants
    --  TODO: figure out how this works lol
    use 'tpope/vim-abolish'



    ---- LSP Support (linting, fixing/formatting, autocompletion)
    -- experimental; ideally switch from ALE to builtin Neovim LSP
    
    -- ALE: linting, fixing, formatting
    use { 'dense-analysis/ale', config = [[require('config.ale')]] }

    -- Completions engine
    use { 'ms-jpq/coq_nvim', branch = 'coq', config = [[require('config.coq')]] }
    -- Signature window
    use 'ray-x/lsp_signature.nvim'
    -- Builtin Neovim LSP
    use { 'neovim/nvim-lspconfig', config = [[require('config.nvim-lsp')]] }
    -- Easy LSP installer
    use { 'williamboman/nvim-lsp-installer' }





    ---- GIT SUPPORT
    -- blamer utility
    use {
        'APZelos/blamer.nvim',
        config = [[require('config.blamer')]],
        cmd = 'BlamerToggle',
        keys = {'<leader>', 'b'} -- only load when <leader>b is pressed
    }

    -- Git & GitHub support
    use { 'tpope/vim-fugitive', config = [[require('config.vim-fugitive')]] }
    use 'tpope/vim-rhubarb'

    -- Display Git changes in gutter
    use 'airblade/vim-gitgutter'



    ---- VISUAL ENHANCEMENTS
    -- OneDark colorscheme
    -- use { 'ful1e5/onedark.nvim', config = [[require('config.onedark')]] }
    use 'ful1e5/onedark.nvim'
    -- use { "ellisonleao/gruvbox.nvim", config = [[require('config.gruvbox')]] }
    
    -- Language pack for better syntax highlighting
    use 'sheerun/vim-polyglot'

    -- statusline
    use { 'nvim-lualine/lualine.nvim', config = [[require('config.lualine')]] }
    -- bufferline
    use { 'akinsho/bufferline.nvim', config = [[require('config.bufferline')]] }

    -- highlight indented lines
    use { 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] }

    -- dim inactive portions of code
    use {
        'folke/twilight.nvim',
        config = [[require('config.twilight')]],
        -- cmd = 'Twilight',
        -- keys = {'<Leader>', 't', 'w'}
    }



    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
