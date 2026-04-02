---- PLUGINS SECTION ---- We use lazy.nvim as our package manager.

-- shorten some commands
local fn = vim.fn

-- Python host detection with cache.
--
-- Problem: exepath() may return a pyenv shim (~/.pyenv/shims/python3). Shims
-- shell out to pyenv for version resolution (~200-400ms) every time the Python
-- provider is spawned. We want the real binary path instead.
--
-- Strategy:
--   1. Read a cached real-binary path from stdpath('cache')/python3_host_prog.
--      If valid, use it immediately (~0.005ms file read).
--   2. Otherwise fall back to exepath() for this session (~0.07ms), and spawn
--      `python3 -c "import sys;print(sys.executable)"` asynchronously to
--      resolve the real path and write it to the cache for next time.
--
-- Cache invalidation: delete ~/.cache/nvim/python3_host_prog manually, or it
-- auto-invalidates when the cached binary no longer exists.
do
    local cache_path = vim.fn.stdpath('cache') .. '/python3_host_prog'

    local function set_prog(path)
        if path and path ~= '' then
            vim.g.python3_host_prog = path
        end
    end

    local function write_cache(path)
        -- Write with newline so f:read('*l') parses correctly on next session,
        -- even if two nvim instances race to create the file simultaneously.
        local f = io.open(cache_path, 'w')
        if f then f:write(path .. '\n'); f:close() end
    end

    local function resolve_and_cache(fallback)
        -- Spawn python3 asynchronously to get the real executable path,
        -- bypassing any shim wrapper. Writes result to cache for next session.
        -- NOTE: vim.fn.* must not be called from libuv callbacks; use vim.schedule.
        local stdout = vim.loop.new_pipe()
        local chunks = {}
        vim.loop.spawn('python3', {
            args  = { '-c', 'import sys; print(sys.executable)' },
            stdio = { nil, stdout, nil },
        }, function()
            local real = table.concat(chunks):gsub('%s+$', '')
            stdout:close()
            if real == '' then return end
            vim.schedule(function()
                if vim.fn.executable(real) == 1 then
                    write_cache(real)
                    -- Upgrade from shim to real binary for this session too
                    if vim.g.python3_host_prog == fallback then
                        vim.g.python3_host_prog = real
                    end
                end
            end)
        end)
        stdout:read_start(function(_, data)
            if data then chunks[#chunks + 1] = data end
        end)
    end

    -- Fast path: use cached real binary if it still exists
    local f = io.open(cache_path, 'r')
    if f then
        local cached = f:read('*l'); f:close()
        if cached and cached ~= '' and vim.fn.executable(cached) == 1 then
            set_prog(cached)
            -- No need to re-resolve; cache is valid
        else
            -- Cache is stale (Python moved/removed); fall back and re-resolve
            local fallback = vim.fn.exepath('python3')
            if fallback == '' then fallback = vim.fn.exepath('python') end
            set_prog(fallback)
            resolve_and_cache(fallback)
        end
    else
        -- No cache yet: set from PATH now, resolve real path in background
        local fallback = vim.fn.exepath('python3')
        if fallback == '' then fallback = vim.fn.exepath('python') end
        set_prog(fallback)
        resolve_and_cache(fallback)
    end
end

-- helper to load config files
local function cfg(name)
    return string.format('require("config/%s")', name)
end

-- Bootstrap lazy.nvim if not already installed
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    ---- UTILITIES

    -- surround highlighted text
    { 'tpope/vim-surround' },

    -- Autopairs support
    {
        'jiangmiao/auto-pairs',
        config = function() require("config/autopairs") end,
    },

    -- easier commenting
    {
        'preservim/nerdcommenter',
        config = function() require("config/nerdcommenter") end,
    },

    -- Better syntax highlighting
    -- Sub-plugins declare nvim-treesitter as THEIR dependency (not the other way)
    -- so lazy guarantees treesitter is on the rtp before their plugin/ files run.
    -- nvim-treesitter-refactor is excluded: it requires nvim-treesitter.query which
    -- was removed from modern nvim-treesitter (moved into vim.treesitter core).
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = false,
        config = function() require("config/treesitter") end,
    },
    { 'nvim-treesitter/nvim-treesitter-textobjects', dependencies = { 'nvim-treesitter/nvim-treesitter' } },
    { 'nvim-treesitter/nvim-treesitter-context',     dependencies = { 'nvim-treesitter/nvim-treesitter' } },
    { 'HiPhish/rainbow-delimiters.nvim',             dependencies = { 'nvim-treesitter/nvim-treesitter' } },

    -- Easy movement around buffer
    {
        'smoka7/hop.nvim',
        config = function() require("config/hop") end,
    },

    -- telescope functionality
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-ui-select.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
        },
        config = function() require("config/telescope") end,
    },

    -- file explorer
    -- VeryLazy defers the ~11ms load cost. The keys spec registers <C-n> immediately at
    -- startup as a lazy stub — independent of VeryLazy — so there is no race condition.
    {
        'kyazdani42/nvim-tree.lua',
        event = 'VeryLazy',
        keys = {
            { '<C-n>', '<cmd>NvimTreeToggle<CR>', desc = 'tree: toggle file explorer' },
        },
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function() require("config/nvim-tree") end,
    },

    -- symbols outline
    -- VeryLazy defers load. The keys spec function is called after lazy loads the plugin,
    -- so 'require("outline")' is safe inside it. It retries up to ~2s for LSP to attach
    -- before giving up and opening anyway (avoids "No response from provider" on fast open).
    {
        'hedyhli/outline.nvim',
        event = 'VeryLazy',
        cmd = 'Outline',
        keys = {
            { '<leader>so', function()
                local attempts = 0
                local function try_open()
                    attempts = attempts + 1
                    local clients = vim.lsp.get_clients({ bufnr = 0 })
                    local ready = false
                    for _, c in ipairs(clients) do
                        if c.server_capabilities and c.server_capabilities.documentSymbolProvider then
                            ready = true
                            break
                        end
                    end
                    if ready or attempts >= 10 then
                        vim.cmd('Outline')
                    else
                        vim.defer_fn(try_open, 200) -- retry every 200ms, up to 2s total
                    end
                end
                try_open()
            end, desc = 'outline: toggle symbol tree' },
        },
        config = function() require("config/symbols-outline") end,
    },

    -- which-key assistant
    {
        "folke/which-key.nvim",
        config = function() require("config/which-key") end,
    },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = { '<C-t>', '<leader>gs', '<leader>tl', '<leader>tv' },
        config = function() require("config/toggleterm") end,
    },

    -- better buf delete functionality
    { 'famiu/bufdelete.nvim' },




    ---- LSP Support (linting, fixing/formatting, autocompletion)

    -- Formatting, Linting
    -- BufReadPost: no point loading LSP tools before a file is open.
    { 'nvimtools/none-ls.nvim', event = 'BufReadPost', config = function() require("config/null-ls") end },

    -- Completion engine (replaces coq.nvim)
    {
        'saghen/blink.cmp',
        version = "*",
        dependencies = {
            'rafamadriz/friendly-snippets',
        },
        config = function() require("config/blink") end,
    },

    -- Signature window
    { 'ray-x/lsp_signature.nvim' },

    -- lightbulb on code actions
    {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
        end,
    },

    -- Package manager for external editor tooling
    {
        "williamboman/mason.nvim",
        version = "*",
        build = ":MasonUpdate",
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
    },

    -- Builtin Neovim LSP
    -- BufReadPost: defers mason registry scanning (~17ms) until a real file is opened.
    -- On first file open there is a brief attach delay; all subsequent files are instant.
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPost',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'saghen/blink.cmp',
        },
        config = function() require("config/nvim-lsp") end,
    },



    ---- Languages

    -- Better clangd integration
    { 'p00f/clangd_extensions.nvim', ft = { 'c', 'cpp' } },

    -- Rust support (replaces simrat39/rust-tools.nvim)
    {
        'mrcjkb/rustaceanvim',
        version = "^5",
        lazy = false,
        init = function() require("config/rustaceanvim") end,
    },

    -- Crates.io dependency management
    {
        'saecki/crates.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = { "BufRead Cargo.toml" },
        config = function() require("config/crates") end,
    },

    -- Go support
    {
        'ray-x/go.nvim',
        ft = { 'go' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function() require("config/go") end,
    },

    -- RON support
    { 'ron-rs/ron.vim', ft = { 'ron' } },



    ---- GIT SUPPORT

    -- Git gutter view, blamer utility, hunk navigation, diff
    {
        'lewis6991/gitsigns.nvim',
        config = function() require("config/gitsigns") end,
    },

    -- Git & GitHub support
    {
        'tpope/vim-fugitive',
        cmd = { 'Git', 'Gwrite', 'Gread', 'GBrowse' },
        config = function() require("config/vim-fugitive") end,
    },
    { 'tpope/vim-rhubarb', cmd = 'GBrowse' },



    ---- VISUAL ENHANCEMENTS

    -- Colorscheme
    {
        'ringtack/onedark.nvim',
        priority = 1000,
        config = function() require("config/color") end,
    },

    -- statusline
    { 'nvim-lualine/lualine.nvim', config = function() require("config/lualine") end },
    -- bufferline
    { 'akinsho/bufferline.nvim', config = function() require("config/bufferline") end },

    -- highlight indented lines
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = {
            'ringtack/onedark.nvim',
            'HiPhish/rainbow-delimiters.nvim',
        },
        config = function() require("config/indent-blankline") end,
    },

    -- better diagnostics/references/qf/loclist interface
    -- VeryLazy defers load; keys spec registers all keymaps immediately at startup as stubs.
    {
        "folke/trouble.nvim",
        event = 'VeryLazy',
        cmd = 'Trouble',
        keys = {
            { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'trouble: toggle diagnostics' },
            { '<leader>xw', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'trouble: workspace diagnostics' },
            { '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'trouble: document diagnostics' },
            { '<leader>xl', '<cmd>Trouble loclist toggle<cr>',                  desc = 'trouble: location list' },
            { '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                   desc = 'trouble: quickfix list' },
        },
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function() require("config/trouble") end,
    },

    -- better messages/cmdline/notifications interface
    {
        "folke/noice.nvim",
        config = function() require("config/noice") end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },

    -- dim inactive portions of code
    {
        'folke/twilight.nvim',
        cmd = 'Twilight',
        -- keys entry makes lazy.nvim register a stub keymap so <Leader>tw works before first
        -- manual :Twilight call (without it the config never runs and the keymap is never set).
        keys = { '<Leader>tw' },
        config = function() require("config/twilight") end,
    },

    -- todo comment highlighter
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function() require("config/todo-comments") end,
    },

    -- Markdown renderer (in-buffer preview with hybrid edit mode)
    {
        'OXY2DEV/markview.nvim',
        lazy = false, -- plugin handles its own lazy loading per-buffer
        config = function() require("config/markview") end,
    },

    -- Colorizer
    {
        'catgoose/nvim-colorizer.lua',
        config = function() require("config/nvim-colorizer") end,
    },

}, {
    ui = { border = "rounded" },
})
