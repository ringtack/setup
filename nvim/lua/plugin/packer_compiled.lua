-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/ringtack/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/ringtack/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/ringtack/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/ringtack/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/ringtack/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    config = { "require('config.ale')" },
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/ale",
    url = "https://github.com/dense-analysis/ale"
  },
  ["blamer.nvim"] = {
    commands = { "BlamerToggle" },
    config = { "require('config.blamer')" },
    keys = { { "", "<leader>" }, { "", "b" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/opt/blamer.nvim",
    url = "https://github.com/APZelos/blamer.nvim"
  },
  ["bufferline.nvim"] = {
    config = { "require('config.bufferline')" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/opt/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  coq_nvim = {
    after = { "nvim-lspconfig" },
    loaded = true,
    only_config = true
  },
  ["indent-blankline.nvim"] = {
    config = { "require('config.indent-blankline')" },
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('config.lualine')" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  nerdcommenter = {
    config = { "require('config.nerdcommenter')" },
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/nerdcommenter",
    url = "https://github.com/preservim/nerdcommenter"
  },
  ["nvim-autopairs"] = {
    config = { "require('config.autopairs')" },
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-lsp-installer"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "nvim-lsp-installer" },
    config = { "require('config.nvim-lsp')" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    after = { "bufferline.nvim", "lualine.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/ful1e5/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-fugitive"] = {
    config = { "require('config.vim-fugitive')" },
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gitgutter"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-gitgutter",
    url = "https://github.com/airblade/vim-gitgutter"
  },
  ["vim-gutentags"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/ringtack/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: ale
time([[Config for ale]], true)
require('config.ale')
time([[Config for ale]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('config.nvim-tree')
time([[Config for nvim-tree.lua]], false)
-- Config for: coq_nvim
time([[Config for coq_nvim]], true)
require('config.coq')
time([[Config for coq_nvim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
require('config.vim-fugitive')
time([[Config for vim-fugitive]], false)
-- Config for: nerdcommenter
time([[Config for nerdcommenter]], true)
require('config.nerdcommenter')
time([[Config for nerdcommenter]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
require('config.indent-blankline')
time([[Config for indent-blankline.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
require('config.autopairs')
time([[Config for nvim-autopairs]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
require('config.lualine')

vim.cmd [[ packadd bufferline.nvim ]]

-- Config for: bufferline.nvim
require('config.bufferline')

vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
require('config.nvim-lsp')

vim.cmd [[ packadd nvim-lsp-installer ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file BlamerToggle lua require("packer.load")({'blamer.nvim'}, { cmd = "BlamerToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <leader> <cmd>lua require("packer.load")({'blamer.nvim'}, { keys = "<lt>leader>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> b <cmd>lua require("packer.load")({'blamer.nvim'}, { keys = "b", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
