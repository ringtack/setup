local o = vim.o
local fn = vim.fn
-- SYNTAX: map('<mode>', '<key sequence>', '<cmd to execute>', '<opts>')
local map = vim.api.nvim_set_keymap



---- DIAGNOSTICS CONFIG
--
-- disable virtual text and sort on severity
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
    focus = false,
    show_header = false,
    source = "if_many",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- set float border highlight color
vim.cmd('hi FloatBorder guifg=DarkGray')

-- show diagnostics on hover
o.updatetime = 200
-- vim.cmd([[
-- autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, border="rounded", show_header=false})
-- ]])

-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or {nil, nil}

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    vim.diagnostic.open_float(0, {scope="cursor"})   -- for neovim 0.6.0+, replaces show_{line,position}_diagnostics
  end
end
vim.cmd [[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold * lua _G.LspDiagnosticsPopupHandler()
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb{sign={enabled=true,priority=12}}
augroup END
]]



-- change UI signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- combine gutter and number
o.signcolumn = "number"



---- ENABLE LANGUAGE SERVERS ----
local nvim_lsp = require('lspconfig')
local coq = require('coq')

-- handlers to redefine function configs
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
}

-- helper function to attach signature
local on_attach_lsp_signature = function(client, bufnr)
  require('lsp_signature').on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      floating_window = true, -- false for virtual text only
      floating_window_above_cur_line = true,
      -- floating_window_off_y = 30,
      transparency = 20,
      handler_opts = {
        border = "rounded"
      },
      doc_lines = 2,   -- restrict documentation shown
      zindex = 50,     -- <=50 so that it does not hide completion preview.
      fix_pos = false, -- Let signature window change its position when needed
      toggle_key = '<A-x>',  -- Press <Alt-x> to toggle signature on and off.
    })
end


-- attach only after lsp connects
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- disable nvim-lsp formatting; use null-ls for formatting
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  -- Activate LSP signature on attach.
  on_attach_lsp_signature(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', ':CodeActionMenu<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<Leader>k', '<cmd>lua vim.diagnostic.goto_prev({float={border="rounded"}})<CR>', opts)
  buf_set_keymap('n', '<Leader>j', '<cmd>lua vim.diagnostic.goto_next({float={border="rounded"}})<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Highlight symbol under cursor
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      hi LspReferenceRead guifg=bg guibg=Gray
      hi LspReferenceText guifg=bg guibg=Gray
      hi LspReferenceWrite guifg=bg guibg=Gray
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
end

local servers = {
  'bashls',               -- Bash
  'clangd',               -- C/C++
  'eslint',               -- JS[X], TS[X], Vue
  'gopls',                -- Go
  'jedi_language_server', -- Python
  'pyright',              -- Python
  'rust_analyzer',        -- Rust
  'sumneko_lua',          -- Lua
  'tsserver'              -- JS[X], TS[X]
}

local capabilities = vim.lsp.protocol.make_client_capabilities() -- disable warnings for clangd
capabilities.offsetEncoding = { "utf-16" }

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
  -- nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    handlers = handlers,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  -- }))
  })
end
