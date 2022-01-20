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
vim.cmd([[
autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, border="rounded"})
]])



-- change UI signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- combine gutter and number
o.signcolumn = "number"

map('n', '<Leader>j', ':lua vim.diagnostic.goto_next({ float =  { border = "rounded" }})<cr>', {})
map('n', '<Leader>k', ':lua vim.diagnostic.goto_prev({ float =  { border = "rounded" }})<cr>', {})



---- ENABLE LANGUAGE SERVERS ----
local nvim_lsp = require('lspconfig')
-- local coq = require('coq')

-- handlers 
local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
}

-- attach only after lsp connects
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

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
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<Leader>k', '<cmd>vim.diagnostic.goto_prev({float={border="rounded"}})<CR>', opts)
  buf_set_keymap('n', '<Leader>j', '<cmd>vim.diagnostic.goto_next({float={border="rounded"}})<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

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

local servers = { 'bashls', 'clangd', 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    handlers = handlers,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
