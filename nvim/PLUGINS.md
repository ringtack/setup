# NeoVim Plugin Reference

**Package manager:** `folke/lazy.nvim` — `:Lazy` to open UI, `:Lazy sync` to install/update all plugins.
**Leader key:** `,` (comma)

---

## Navigation

### smoka7/hop.nvim — EasyMotion-style jumps
`f` / `F` / `t` / `T` are overridden to use hop-powered char hints (current line only).

| Key | Action |
|-----|--------|
| `<leader>w` | Hint words in buffer |
| `f{char}` | Hop to char after cursor (current line) |
| `F{char}` | Hop to char before cursor (current line) |
| `t{char}` | Hop to before char after cursor |
| `T{char}` | Hop to after char before cursor |

### nvim-telescope/telescope.nvim — Fuzzy finder
Extensions loaded: `fzf`, `file_browser`, `ui-select`, `noice`.

`<CR>` on a result is **smart**: source files open in nvim; images/PDFs/media (`.png`, `.jpg`, `.pdf`, `.mp4`, etc.) open in the macOS default app via `open`.

| Key | Action |
|-----|--------|
| `<leader>lg` | Live grep across project |
| `<leader>ff` | Find files (includes hidden) |
| `<leader>fb` | List open buffers |
| `<leader>ft` | Search TODO comments |
| `<leader>tn` | Browse noice message history |

**File browser shortcuts** (inside browser):

| Key | Action |
|-----|--------|
| `<C-n>` | Create file/dir |
| `<C-r>` | Rename |
| `<C-d>` | Delete |

### kyazdani42/nvim-tree.lua — File explorer

| Key | Action |
|-----|--------|
| `<C-n>` | Toggle NvimTree |

---

## Editing Utilities

### tpope/vim-surround — Surround text objects
Standard vim-surround: `cs"'` (change `"` to `'`), `ds"` (delete `"`), `ysiw"` (surround word).

### jiangmiao/auto-pairs — Auto-close brackets/quotes
Automatically inserts matching pair for `(`, `[`, `{`, `"`, `'`.

### preservim/nerdcommenter — Code commenting

| Key | Action |
|-----|--------|
| `<leader>cc` | Comment line/selection |
| `<leader>cu` | Uncomment line/selection |
| `<leader>c<space>` | Toggle comment |

### famiu/bufdelete.nvim — Smarter buffer deletion

| Key | Action |
|-----|--------|
| `<leader><Esc>` | Delete buffer without closing split |

---

## LSP & Completion

### saghen/blink.cmp — Completion engine (replaces coq.nvim)
Preset: `default`. Snippet provider: `default` (uses nvim built-in `vim.snippet` + `friendly-snippets`).

| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Navigate completion menu |
| `<CR>` | Accept completion |
| `<C-s>` | Show/hide signature help |
| `<C-space>` | Manually trigger completion |

### neovim/nvim-lspconfig — LSP client configuration
Servers managed by Mason: `asm_lsp`, `bashls`, `clangd`, `dockerls`, `eslint`, `gopls`,
`jedi_language_server`, `lua_ls`, `pyright`, `rust_analyzer`, `ts_ls`.

**LSP keymaps** (active in any buffer with an attached LSP):

| Key | Action |
|-----|--------|
| `<C-]>` | Go to definition |
| `K` | Hover documentation (press again to enter float and scroll) |
| `<leader>gi` | Go to implementation |
| `<leader>D` | Go to type definition |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer (async) |
| `<leader>ih` | Toggle inlay hints |
| `<leader>lr` | Find all references (Telescope) — note: uses `<leader>lr` not `gr` because nvim 0.11 installs `grr`/`grn`/`gra`/`gri` buffer-locally after every LspAttach, clobbering any `gr*` keymap we set and introducing a `timeoutlen` ambiguity on plain `gr` |
| `<leader>k` | Go to previous diagnostic |
| `<leader>j` | Go to next diagnostic |
| `<space>wa` | Add workspace folder |
| `<space>wr` | Remove workspace folder |
| `<space>wl` | List workspace folders |
| `<A-x>` | Toggle LSP signature help |

### williamboman/mason.nvim — LSP/tool installer

| Command | Action |
|---------|--------|
| `:Mason` | Open Mason UI |
| `:MasonInstall <name>` | Install a tool |

### ray-x/lsp_signature.nvim — Signature hints
Automatically shows function signature in a float while typing. `<A-x>` toggles it.

### kosayoda/nvim-lightbulb — Code action indicator
Shows a lightbulb `💡` sign in the gutter when code actions are available at the cursor.

### nvimtools/none-ls.nvim — Formatters/linters via LSP (null-ls fork)
Formatters: `black`, `isort` (Python), `clang_format` (C/C++), `gofmt`/`goimports`/`golines` (Go), `prettierd` (JS/TS/CSS/HTML/MD).
Linters: `cppcheck` (C/C++), `markdownlint` (requires `markdownlint-cli` in PATH).

### p00f/clangd_extensions.nvim — Enhanced C/C++ LSP

| Key | Action |
|-----|--------|
| `<leader>sh` | Switch source/header |
| `<leader>th` | Type hierarchy |

### mrcjkb/rustaceanvim — Rust LSP + tools (replaces rust-tools.nvim)
Configured via `vim.g.rustaceanvim` (set before plugin load). Uses `rust-analyzer` with clippy
on-save and proc macro support.

| Key | Action |
|-----|--------|
| `<leader>em` | Expand macro |
| `<leader>mu` | Move item up |
| `<leader>md` | Move item down |
| `<leader>oc` | Open Cargo.toml |

Standard LSP keymaps also apply (see above).

### saecki/crates.nvim — Cargo dependency management
Auto-activates on `Cargo.toml`. Provides LSP-style completions, hover docs, and code actions
for crate versions.

### ray-x/go.nvim — Go language support
Configured in `lua/config/go.lua`. Provides Go-specific commands (`:GoFmt`, `:GoTest`, etc.).

---

## Diagnostics & Code Navigation

### folke/trouble.nvim — Diagnostics panel (v3)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics panel |
| `<leader>xw` | Toggle workspace diagnostics |
| `<leader>xd` | Toggle document diagnostics |
| `<leader>xl` | Toggle location list |
| `<leader>xq` | Toggle quickfix list |

"No results for diagnostics" is expected when the LSP reports no errors/warnings — it means the buffer is clean.

### hedyhli/outline.nvim — Symbol tree (replaces symbols-outline.nvim)

| Key | Action |
|-----|--------|
| `<leader>so` | Toggle symbol outline |

### folke/which-key.nvim — Keybinding hints

| Key | Action |
|-----|--------|
| `<space>wk` | Open WhichKey menu manually |

Pops up automatically after `timeoutlen = 500ms` showing available key completions with descriptions.

---

## Syntax & Visual

### nvim-treesitter/nvim-treesitter — Syntax highlighting & more
Always loaded (not lazy). Parsers: bash, c, cpp, css, dockerfile, go, gomod, glsl, html,
javascript, json, latex, lua, make, markdown, markdown_inline, proto, python, regex, rust,
typescript, toml, yaml.

Highlighting and indentation are enabled via `FileType` autocmds. Textobject keymaps:

**Select** (visual / operator-pending):

| Key | Text object |
|-----|------------|
| `af` / `if` | outer / inner function |
| `ac` / `ic` | outer / inner class |
| `al` / `il` | outer / inner loop |
| `ab` / `ib` | outer / inner block |
| `ar` / `ir` | outer / inner parameter |

**Swap:**

| Key | Action |
|-----|--------|
| `<leader>a` | Swap parameter with next |
| `<leader>A` | Swap parameter with previous |

**Move:**

| Key | Action |
|-----|--------|
| `]m` / `[m` | Next / prev function start |
| `]M` / `[M` | Next / prev function end |
| `]]` / `[[` | Next / prev class start |
| `][` / `[]` | Next / prev class end |
| `]l` / `[l` | Next / prev loop end / start |
| `]b` / `[b` | Next / prev block end / start |

### nvim-treesitter/nvim-treesitter-context — Sticky context
Shows the current function/class scope at the top of the window (max 3 lines).

### HiPhish/rainbow-delimiters.nvim — Rainbow brackets
Colorizes bracket pairs at different nesting levels.

### lukas-reineke/indent-blankline.nvim (v3) — Indent guides
Shows vertical indent lines. Scope highlighting uses rainbow colors that match
`rainbow-delimiters.nvim`.

### catgoose/nvim-colorizer.lua — Color code previews
Highlights hex colors, RGB values, etc. inline in the buffer.

---

## Markdown

### OXY2DEV/markview.nvim — In-buffer markdown renderer
Renders headings, tables, code blocks, lists, and block quotes directly in the buffer.
Requires `markdown` and `markdown_inline` tree-sitter parsers (already installed).

| Key | Action |
|-----|--------|
| `<leader>mv` | Toggle preview on/off |
| `<leader>mh` | Toggle **hybrid mode** |
| `<leader>ms` | Toggle **split view** |

**Modes:**
- **Default (on)** — full in-buffer rendering; best for reading
- **Hybrid** — renders everything except the node under the cursor; best for editing
- **Split** — side-by-side raw + rendered panes

---

## UI & Appearance

### ringtack/onedark.nvim — Colorscheme
Loaded with `priority = 1000` so it applies before all other plugins.
Config: italic comments and function names.

### nvim-lualine/lualine.nvim — Statusline
Theme: onedark. Shows: mode | filename, branch | git diff | diagnostics | filetype, progress | location.

### akinsho/bufferline.nvim — Buffer tabs
Shows open buffers as tabs at top. Close icons hidden; bar only shown when 2+ buffers open.

| Key | Action |
|-----|--------|
| `<leader>]` | Next buffer |
| `<leader>[` | Previous buffer |

### folke/noice.nvim — Enhanced UI (messages, cmdline, popupmenu)
Replaces the default cmdline, messages, and popup menu with styled nui-based floats.
LSP signature and doc border enabled. Popupmenu backend: `nui`.
Shell command output (`:!cmd`) shown as a notification.

| Command | Action |
|---------|--------|
| `:Noice` | Browse message history |
| `:Telescope noice` / `<leader>tn` | Search message history |

### rcarriga/nvim-notify — Notification popups
Used by noice as the notification backend.

### folke/twilight.nvim — Dim inactive code

| Key | Action |
|-----|--------|
| `<leader>tw` | Toggle Twilight |

Shows only the current 15-line context at full brightness; dims everything else.

### folke/todo-comments.nvim — TODO highlighting
Highlights `TODO:`, `FIXME:`, `NOTE:`, `HACK:`, `WARN:`, `PERF:` etc. in comments.

| Key | Action |
|-----|--------|
| `<leader>ft` | Search all TODOs with Telescope |

---

## Git

### lewis6991/gitsigns.nvim — Git gutter & hunk operations

| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage entire buffer |
| `<leader>hu` | Undo stage hunk |
| `<leader>hR` | Reset entire buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Toggle current-line blame |
| `<leader>hl` | Toggle line highlight |
| `<leader>hw` | Toggle word diff |
| `<leader>hd` | Diff this file |
| `<leader>hD` | Diff against last commit |
| `<leader>td` | Toggle deleted lines |
| `ih` (text obj) | Select hunk (visual/operator) |

### tpope/vim-fugitive + tpope/vim-rhubarb — Git commands
Standard fugitive commands: `:Git`, `:Gwrite`, `:Gread`, `:GBrowse` (requires rhubarb for GitHub).

### akinsho/toggleterm.nvim — Integrated terminal + GitUI

| Key | Action |
|-----|--------|
| `<C-t>` | Toggle floating terminal |
| `<leader>gs` | Open GitUI (TUI git client) |
| `<leader>tl` | Send current line to terminal |
| `<leader>tv` | Send visual selection to terminal |

Terminal opens as a 75%-width curved float. GitUI uses the same float style.

---

## Global Keymaps (`maps.lua`)

| Key | Action |
|-----|--------|
| `<leader>d` | Horizontal split |
| `<leader>r` | Vertical split |
| `<C-J/K/H/L>` | Navigate splits |
| `<leader>]` | Next buffer |
| `<leader>[` | Previous buffer |
| `<leader><Esc>` | Delete buffer |
| `<A-j>` / `<A-k>` | Move line/selection down/up |
| `j` / `k` | Smart jump (adds to jumplist when count > 10) |
| `Q` | Disabled (no Ex mode) |

---

## Verification Commands

After first launch, run `:Lazy sync`, then:

```
:checkhealth          — overall health check
:checkhealth markview — verify markview parsers
:LspInfo              — LSP attachment status (open a .go, .rs, etc. file first)
:Mason                — confirm all servers installed
:Noice                — verify cmdline UI
<leader>xx            — verify Trouble opens
<leader>ca            — verify code actions (on a diagnostic)
:RustLsp expandMacro  — verify rustaceanvim (in a .rs file)
```
