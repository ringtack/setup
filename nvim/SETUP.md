# Neovim Configuration — From-Scratch Setup Guide

**Package manager:** `folke/lazy.nvim` (auto-bootstrapped on first launch — no manual install needed)
**Minimum Neovim version:** 0.11 (uses `vim.lsp.config('*', ...)` API)
**Leader key:** `,` (comma)

---

## 1. Neovim itself

Install Neovim ≥ 0.11. On the personal machine this comes from **Flox**
(`~/.flox/run/aarch64-darwin.default.dev/bin/nvim`). On an enterprise machine
use whichever package manager is available:

```sh
# macOS (Homebrew)
brew install neovim

# Linux (build from source or use a release binary)
# https://github.com/neovim/neovim/releases
```

Then clone this config into the standard location:

```sh
git clone <your-nvim-config-repo> ~/.config/nvim
```

---

## 2. System dependencies

These must be on your `$PATH` **before** launching Neovim.

### 2a. Required for core functionality

| Tool | Purpose | Install |
|------|---------|---------|
| `git` | lazy.nvim bootstrap, gitsigns, fugitive | system package manager |
| `make` | `telescope-fzf-native` native build | `brew install make` / system pkg |
| `rg` (ripgrep) | Telescope live-grep backend | `brew install ripgrep` |
| `gitui` | Floating Git TUI (`<leader>gs`) | `brew install gitui` / `cargo install gitui` |
| Nerd Font | Icons in lualine, nvim-tree, bufferline, lightbulb | [nerdfonts.com](https://www.nerdfonts.com/) — set in terminal |

### 2b. Language runtimes

| Runtime | Purpose | Install |
|---------|---------|---------|
| **Node.js / npm** | `ts_ls`, `eslint`, `prettierd`, Mason | `brew install node` or `nvm` |
| **Python (pyenv)** | `jedi_language_server`, `pyright`, `black`, `isort` | see §2c |
| **Go toolchain** | `gopls`, `gofmt`, `goimports`, `golines` | [go.dev/dl](https://go.dev/dl/) |
| **Rust (rustup)** | `rust-analyzer`, `rustfmt` | `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \| sh` |
| **LLVM/clang** | `clangd`, `clang-format` | `brew install llvm` → ensure `/opt/homebrew/opt/llvm/bin` is on PATH |

### 2c. Python via pyenv (important)

`plugins.lua` hardcodes the Python path:

```lua
vim.g.python3_host_prog = fn.expand('~/.pyenv/shims/python')
```

Install pyenv and set a global Python version:

```sh
brew install pyenv
pyenv install 3.12          # or any 3.x
pyenv global 3.12
pip install pynvim          # neovim Python provider
pip install black isort     # formatters used by none-ls
```

If you cannot use pyenv on the enterprise machine, either:
- Symlink: `mkdir -p ~/.pyenv/shims && ln -s $(which python3) ~/.pyenv/shims/python`
- Or change the `python3_host_prog` line in `lua/plugins.lua` to your actual Python path.

### 2d. Go formatters

```sh
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/segmentio/golines@latest
```

### 2e. Node formatters/linters

```sh
npm install -g @fsouza/prettierd markdownlint-cli
```

Then create `~/.markdownlint.yaml` (the config referenced in `null-ls.lua`).
A minimal starting config:

```yaml
# ~/.markdownlint.yaml
default: true
MD013: false   # line-length
MD033: false   # inline HTML
```

### 2f. C/C++ linter

```sh
brew install cppcheck
```

---

## 3. First launch

Open Neovim — lazy.nvim will clone itself automatically, then install all
plugins:

```sh
nvim
```

Inside Neovim, lazy will open its UI and install ~30 plugins. After it
completes, Mason will download LSP servers. This can take a few minutes.

If Mason doesn't auto-install, run:

```
:MasonUpdate
:Lazy sync
```

---

## 4. LSP servers (Mason-managed)

The following are declared in `lua/config/nvim-lsp.lua` under
`ensure_installed` and are installed automatically by Mason:

| Server | Language |
|--------|----------|
| `asm_lsp` | Assembly |
| `bashls` | Bash (uses shellcheck internally) |
| `clangd` | C / C++ |
| `dockerls` | Dockerfile |
| `eslint` | JS, TS, JSX, TSX, Vue |
| `gopls` | Go |
| `jedi_language_server` | Python |
| `lua_ls` | Lua |
| `pyright` | Python (type-checking) |
| `rust_analyzer` | Rust (installed by Mason, *started* by rustaceanvim — not by lspconfig) |
| `ts_ls` | JS / TS |

Verify after startup: `:Mason` (servers should show as installed).

---

## 5. Formatters / linters (none-ls / null-ls)

These are NOT managed by Mason — they must be on your PATH:

| Tool | Language | Source |
|------|---------|--------|
| `black` | Python | `pip install black` |
| `isort` | Python | `pip install isort` |
| `clang-format` | C / C++ | bundled with LLVM |
| `gofmt` | Go | bundled with Go toolchain |
| `goimports` | Go | `go install golang.org/x/tools/cmd/goimports@latest` |
| `golines` | Go | `go install github.com/segmentio/golines@latest` |
| `prettierd` | JS/TS/CSS/HTML/JSON/YAML/MD | `npm install -g @fsouza/prettierd` |
| `cppcheck` | C / C++ | `brew install cppcheck` |
| `markdownlint` | Markdown | `npm install -g markdownlint-cli` |

**Format on save** is enabled for all buffers with an attached LSP client.
Rust formatting is handled by `rust-analyzer` directly (rustfmt under the hood).

---

## 6. Colorscheme

The config uses `ringtack/onedark.nvim` — a personal GitHub fork. lazy.nvim
fetches it from GitHub automatically. No extra steps needed beyond having
internet access to `github.com`.

---

## 7. WakaTime

`wakatime/vim-wakatime` is installed as a plugin. On first launch you will be
prompted for your WakaTime API key. Have it ready, or skip by pressing Enter
(it won't affect other functionality).

---

## 8. OS-specific notes

### macOS (personal machine)

- Neovim comes from Flox; other tools from Homebrew or Cargo.
- LLVM is at `/opt/homebrew/opt/llvm/bin` — add to PATH:
  ```sh
  export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
  ```
- Nerd Font installed and configured in iTerm2/Terminal.

### Linux / enterprise macOS

- Replace Flox with your distro's package manager or build Neovim from source.
- LLVM path may differ; clangd from Mason can substitute for system clang if
  system LLVM is too old.
- `gitui` may not be available — the `<leader>gs` keybind simply won't open
  anything. Everything else still works.
- If npm/node are not available globally, you can skip `prettierd`, `ts_ls`,
  and `eslint` — Mason will fail to install them but won't break other servers.
- Corporate proxies: configure `git` and `npm` proxy settings before first
  launch so lazy.nvim and Mason can reach GitHub/npm.
- Clipboard: ensure `xclip`/`xsel` (X11) or `wl-clipboard` (Wayland) is
  installed, otherwise yank/paste to system clipboard won't work.

---

## 9. Verification checklist

After first launch completes:

```
:checkhealth              — overall health; aim for no ERRORs
:Mason                    — all 11 servers should be installed
:Lazy                     — all plugins installed/loaded
```

Open a file of each language you care about and run:

```
:LspInfo                  — confirms server attached
K                         — hover docs work
<leader>ca                — code actions available
<leader>xx                — Trouble panel opens
<leader>ff                — Telescope find-files opens
<C-t>                     — floating terminal opens
<leader>gs                — GitUI opens (if gitui installed)
:RustLsp expandMacro      — rustaceanvim working (in a .rs file)
```

---

## 10. Quick reference: key mappings

See `PLUGINS.md` for the full keybinding reference. Key leader shortcuts:

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>lg` | Live grep |
| `<leader>fb` | List buffers |
| `<C-n>` | Toggle file tree |
| `<leader>so` | Toggle symbol outline |
| `<C-]>` | Go to definition |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format buffer |
| `<leader>xx` | Diagnostics panel |
| `<C-t>` | Floating terminal |
| `<leader>gs` | GitUI |
| `<leader>hb` | Toggle git blame |
| `<leader>w` | Hop to word |
