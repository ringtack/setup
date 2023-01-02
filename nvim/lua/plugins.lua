---- PLUGINS SECTION ---- We use Packer as our package manager.

-- shorten some commands
local fn = vim.fn

local function get_config(name)
    return string.format('require("config/%s")', name)
end

-- Bootstrap Packer if not already installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path,
    })
    print("Installing packer...")
    vim.api.nvim_command("packadd packer.nvim")
end

-- manually set python executable for faster load times
-- see https://www.redd.it/r9acxp/
vim.g.python3_host_prog = fn.expand('~/.pyenv/shims/python')

-- Only required if packer is configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

-- Run :PackerCompile whenever a configuration is changed
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

local packer = require('packer')

packer.init({
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
    display = { -- Have packer use a popup window
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- install packages
return packer.startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'



    ---- UTILITIES
    -- surround highlighted text
    use 'tpope/vim-surround'

    -- Autopairs support
    use 'jiangmiao/auto-pairs'

    -- easier commenting
    use {
        'preservim/nerdcommenter',
        config = get_config('nerdcommenter'),
    }

    -- Better syntax highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        config = get_config('treesitter'),
        run = ':TSUpdate',
    }
    -- rainbow parentheses
    use { 'p00f/nvim-ts-rainbow' }
    -- better highlighting, refactoring
    use { 'nvim-treesitter/nvim-treesitter-refactor' }
    -- better textobject operations
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    -- function contexts
    use { 'nvim-treesitter/nvim-treesitter-context' }


    -- Easy movement around buffer
    -- TODO: evaluate Leap at some point, and see which one I like better
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = get_config('hop'),
    }

    -- telescope functionality
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
        config = get_config('telescope'),
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'nvim-telescope/telescope-file-browser.nvim' }

    -- file explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = get_config('nvim-tree'),
    }

    -- symbols outline
    use { "simrat39/symbols-outline.nvim", config = get_config('symbols-outline') }

    -- which-key assistant
    use {
        "folke/which-key.nvim",
        config = get_config("which-key"),
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = get_config('toggleterm'),
    }
    -- Like VSCode's SSH thing?? 
    -- use {
        -- 'chipsenkbeil/distant.nvim',
        -- config = function()
            -- require('distant').setup {
                -- -- 1. Ensures that distant servers terminate with no connections
                -- -- 2. Provides navigation bindings for remote directories
                -- -- 3. Provides keybinding to jump into a remote file's parent directory
                -- ['*'] = require('distant.settings').chip_default()
            -- }
        -- end
    -- }

    -- better buf delete functionality
    use { 'famiu/bufdelete.nvim' }

    -- time tracker
    use 'wakatime/vim-wakatime'



    ---- LSP Support (linting, fixing/formatting, autocompletion)

    -- Formatting, Linting
    use { 'jose-elias-alvarez/null-ls.nvim', config = get_config('null-ls') }

    -- Completions engine
    use { 'ms-jpq/coq_nvim', branch = 'coq', config = get_config('coq') }
    -- Signature window
    use 'ray-x/lsp_signature.nvim'

    -- lightbulb on code actions; enabled in config.nvim-lsp
    use {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('nvim-lightbulb').setup({autocmd = {enabled = true}})
        end,
    }
    -- better code actions menu; enabled in config.nvim-lsp
    use 'weilbith/nvim-code-action-menu'

    -- Builtin Neovim LSP
    use {
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        }, -- easy LSP/Linter/etc installer
        config = get_config('nvim-lsp')
    }




    ---- Languages (configured in config/nvim-lsp.lua)

    -- Better clangd integration
    use { 'p00f/clangd_extensions.nvim' }
    -- Rust support
    use { 'simrat39/rust-tools.nvim' }

    -- RON support
    use { 'ron-rs/ron.vim' }





    ---- GIT SUPPORT
    -- blamer utility
    use {
        'APZelos/blamer.nvim',
        config = get_config('blamer'),
        -- cmd = 'BlamerToggle',
        -- keys = {'<Leader>', 'b'}
    }

    -- Git & GitHub support
    use { 'tpope/vim-fugitive', config = get_config('vim-fugitive') }
    use 'tpope/vim-rhubarb'

    -- Display Git changes in gutter
    use 'airblade/vim-gitgutter'



    ---- VISUAL ENHANCEMENTS
    -- OneDark colorscheme
    use 'ful1e5/onedark.nvim'

    -- statusline
    use { 'nvim-lualine/lualine.nvim', config = get_config('lualine') }
    -- bufferline
    use { 'akinsho/bufferline.nvim', config = get_config('bufferline') }

    -- highlight indented lines
    use { 'lukas-reineke/indent-blankline.nvim', config = get_config('indent-blankline') }

    -- better diagnostics/references/qf/loclist interface
    use {
        "folke/trouble.nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = get_config("trouble"),
    }

    -- better messages/cmdline/notifications interface
    -- TODO: fix popupmenu integration with Coq eventually
    use({
        "folke/noice.nvim",
        config = get_config("noice"),
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    })

    -- better notifications
    -- use { "rcarriga/nvim-notify" }

    -- dim inactive portions of code
    use {
        'folke/twilight.nvim',
        config = get_config('twilight'),
        -- cmd = 'Twilight',
        -- keys = {'<Leader>', 't', 'w'}
    }

    -- todo comment highligher
    use {
        'folke/todo-comments.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = get_config('todo-comments')
    }

    -- notification for LSP progress
    -- TODO: use Noice for now
    -- use { 'j-hui/fidget.nvim', config = function() require("fidget").setup({}) end }

    -- better folds
    -- TODO: figure out how folds work in more detail at some point
    use {
        'kevinhwang91/nvim-ufo',
        config = get_config('ufo'),
        requires = 'kevinhwang91/promise-async',
    }

    -- Dim inactive splits
    use {
        'sunjon/shade.nvim',
        config = function()
            require("shade").setup{
                keys = { toggle = '<Leader>sh' }, -- need to disable for Mason compatibility
            }
        end,
    }

    -- Support missing highlight colors
    use {
        'folke/lsp-colors.nvim',
        config = get_config('lsp-colors'),
    }

    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = get_config('nvim-colorizer'),
    }



    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)


---- Maybe fix later, probably not though
-- tab out of pairs
-- TODO: fix compatibility with coq :(
-- use {
-- 'abecodes/tabout.nvim',
-- config = get_config('tabout'),
-- requires = {'nvim-treesitter'},
-- after = {'coq_nvim'},
-- }

-- easily replace word variants
--  TODO: figure out how this works lol
-- use 'tpope/vim-abolish'

-- nvim-autopairs never seems to work w/ <CR> :/
-- use {
-- "windwp/nvim-autopairs",
-- config = get_config('nvim-autopairs'),
-- }

-- Other colorschemes, currently I like OneDark the most
-- use { 'ful1e5/onedark.nvim', config = get_config('onedark') }
-- use { "ellisonleao/gruvbox.nvim", config = get_config('gruvbox') }
-- use 'sainnhe/everforest'

-- Language pack for better syntax highlighting
-- NOTE: probably don't need with treesitter anymore
-- use 'sheerun/vim-polyglot'
