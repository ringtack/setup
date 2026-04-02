#!/usr/bin/env zsh
#
# setup.sh — Verify and set up the Neovim configuration environment.
#
# Usage:
#   ./setup.sh            Interactive: checks all tools, prompts to install missing ones.
#   ./setup.sh --dryrun   Checks only: reports what is missing without installing.
#
# Run from an interactive terminal so your full PATH (pyenv, cargo, go, flox, etc.)
# is available.
#
# Exit codes:
#   0  All required tools present (optional/recommended warnings do not affect this).
#   1  One or more required tools are missing.

setopt no_unset

# ── Color setup ──────────────────────────────────────────────────────────────

if [[ -t 1 ]]; then
    C_GREEN=$'\033[0;32m'
    C_RED=$'\033[0;31m'
    C_YELLOW=$'\033[1;33m'
    C_CYAN=$'\033[0;36m'
    C_BOLD=$'\033[1m'
    C_RESET=$'\033[0m'
else
    C_GREEN='' C_RED='' C_YELLOW='' C_CYAN='' C_BOLD='' C_RESET=''
fi

# ── Argument parsing ──────────────────────────────────────────────────────────

DRYRUN=0

for arg in "$@"; do
    case $arg in
        --dryrun) DRYRUN=1 ;;
        --help|-h)
            print "Usage: $0 [--dryrun]"
            print "  --dryrun  Report what is missing without installing anything."
            exit 0
            ;;
        *)
            print "Unknown argument: $arg" >&2
            exit 1
            ;;
    esac
done

# ── Counters ─────────────────────────────────────────────────────────────────

typeset -i PASS=0 FAIL=0 WARN=0

# ── Package manager detection ─────────────────────────────────────────────────
#
# _pkgcmd <flox_pkg> <brew_pkg>  →  prints the appropriate system install command.
# Language-specific tools (go install, pip install, npm install -g) bypass this.

if command -v floxpm > /dev/null 2>&1; then
    _PKGMGR=floxpm
elif command -v flox > /dev/null 2>&1; then
    _PKGMGR=flox
elif command -v brew > /dev/null 2>&1; then
    _PKGMGR=brew
else
    _PKGMGR=none
fi

_pkgcmd() {
    local flox_pkg=$1 brew_pkg=$2
    case $_PKGMGR in
        floxpm) print "floxpm install nixpkgs.stable.$flox_pkg" ;;
        flox)   print "flox install nixpkgs.stable.$flox_pkg" ;;
        brew)   print "brew install $brew_pkg" ;;
        *)      print "# no supported package manager found — install $brew_pkg manually" ;;
    esac
}

# ── Output helpers ────────────────────────────────────────────────────────────

_ok()      { printf '%s✓%s %s\n' "$C_GREEN"  "$C_RESET" "$*"; (( PASS++ )) }
_fail()    { printf '%s✗%s %s\n' "$C_RED"    "$C_RESET" "$*"; (( FAIL++ )) }
_warn()    { printf '%s⚠%s %s\n' "$C_YELLOW" "$C_RESET" "$*"; (( WARN++ )) }
_info()    { printf '%s→%s %s\n' "$C_CYAN"   "$C_RESET" "$*" }
_section() { printf '\n%s── %s ──%s\n' "$C_BOLD" "$*" "$C_RESET" }

# ── Core prompt helper ────────────────────────────────────────────────────────
#
# _maybe_install <label> <install_cmd>
#   dryrun=1: prints what would run, no action.
#   dryrun=0: prompts user, runs cmd on confirmation.

_maybe_install() {
    local label=$1 cmd=$2
    if (( DRYRUN )); then
        _info "Would run: $cmd"
        return
    fi
    printf '  Install %s? [y/N] ' "$label"
    local ans
    read -r ans
    if [[ ${ans:l} == y ]]; then
        eval "$cmd"
    fi
}

# ── Binary check helpers ──────────────────────────────────────────────────────
#
# Three tiers:
#   _check_required     Missing → fail (affects exit code) + install prompt.
#   _check_recommended  Missing → warn (does NOT affect exit code) + install prompt.
#   _check_optional     Missing → warn, no prompt (purely informational).

_check_required() {
    local label=$1 bin=$2 cmd=$3
    local _bin_path
    _bin_path=$(command -v "$bin" 2>/dev/null) || true
    if [[ -n $_bin_path ]]; then
        _ok "$label  ($_bin_path)"
    else
        _fail "$label  ($bin not found)"
        _maybe_install "$bin" "$cmd"
    fi
}

_check_recommended() {
    local label=$1 bin=$2 cmd=$3
    local _bin_path
    _bin_path=$(command -v "$bin" 2>/dev/null) || true
    if [[ -n $_bin_path ]]; then
        _ok "$label  ($_bin_path)"
    else
        _warn "$label  ($bin not found — recommended)"
        _maybe_install "$bin" "$cmd"
    fi
}

_check_optional() {
    local label=$1 bin=$2 cmd=$3
    local _bin_path
    _bin_path=$(command -v "$bin" 2>/dev/null) || true
    if [[ -n $_bin_path ]]; then
        _ok "$label  ($_bin_path)"
    else
        _warn "$label  ($bin not found — optional)"
        _info "Install if needed: $cmd"
    fi
}

# ── Version comparison ────────────────────────────────────────────────────────
#
# _version_ge <version_str> <req_major> <req_minor>  →  returns 0 if ≥ req

_version_ge() {
    local ver=$1 req_major=$2 req_minor=$3
    local got_major got_minor
    got_major=$(print "$ver" | cut -d. -f1)
    got_minor=$(print "$ver" | cut -d. -f2)
    (( got_major > req_major || ( got_major == req_major && got_minor >= req_minor ) ))
}

# =============================================================================
# Checks
# =============================================================================

# ── Core ──────────────────────────────────────────────────────────────────────

_section "Core"

# Neovim — required, must be ≥ 0.11 for the vim.lsp.config('*', …) API.
_nvim_path=$(command -v nvim 2>/dev/null) || true
if [[ -z $_nvim_path ]]; then
    _fail "neovim  (nvim not found)"
    _maybe_install "neovim" "$(_pkgcmd neovim neovim)"
else
    _nvim_ver=$(nvim --version 2>/dev/null | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    if _version_ge "$_nvim_ver" 0 11; then
        _ok "neovim $_nvim_ver  (≥ 0.11 required, $_nvim_path)"
    else
        _fail "neovim $_nvim_ver  (too old — ≥ 0.11 required for vim.lsp.config API)"
        _maybe_install "neovim" "$(_pkgcmd neovim neovim)"
    fi
fi
unset _nvim_path _nvim_ver

_check_required \
    "git" \
    "git" \
    "$(_pkgcmd git git)"

_check_required \
    "make  (telescope-fzf-native native build)" \
    "make" \
    "$(_pkgcmd gnumake make)"

_check_required \
    "rg / ripgrep  (telescope live-grep backend)" \
    "rg" \
    "$(_pkgcmd ripgrep ripgrep)"

# ── Optional tools ────────────────────────────────────────────────────────────

_section "Optional tools"

_check_recommended \
    "gitui  (leader-gs floating TUI git client)" \
    "gitui" \
    "$(_pkgcmd gitui gitui)"

# ── Python ────────────────────────────────────────────────────────────────────

_section "Python"

# python3 is used for nvim's Python host (python3_host_prog); see plugins.lua.
_py_path=$(command -v python3 2>/dev/null) || true
if [[ -n $_py_path ]]; then
    _py_ver=$(python3 --version 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    _py_real=$(python3 -c 'import sys; print(sys.executable)' 2>/dev/null)
    _ok "python3 $_py_ver  ($_py_path)"
    if [[ -n $_py_real && $_py_real != $_py_path ]]; then
        _info "Real binary (shim resolved to): $_py_real"
        _info "If Python changes, delete ~/.cache/nvim/python3_host_prog to refresh."
    fi
else
    _warn "python3  (not found — needed for nvim Python host)"
    _maybe_install "python3" "$(_pkgcmd python3 python3)"
fi
unset _py_path _py_ver _py_real

# pynvim: not actively used by any current plugin, but avoids :checkhealth warnings.
if command -v python3 > /dev/null 2>&1; then
    if python3 -c 'import pynvim' 2>/dev/null; then
        _ok "pynvim  (Python provider package installed)"
    else
        _warn "pynvim  (not installed — silences :checkhealth warning)"
        _info "Install if needed: pip install pynvim"
    fi
fi

# ── Node.js ───────────────────────────────────────────────────────────────────

_section "Node.js"

_check_recommended \
    "node  (required by ts_ls and eslint LSP servers via Mason)" \
    "node" \
    "$(_pkgcmd nodejs node)"

_check_recommended \
    "npm  (used to install prettierd, markdownlint-cli)" \
    "npm" \
    "$(_pkgcmd nodejs node)"

_check_optional \
    "prettierd  (null-ls formatter: JS/TS/CSS/HTML/JSON/YAML/Markdown)" \
    "prettierd" \
    "npm install -g @fsouza/prettierd"

# ── Go ────────────────────────────────────────────────────────────────────────

_section "Go"

_check_recommended \
    "go toolchain  (required by gopls LSP server)" \
    "go" \
    "$(_pkgcmd go go)"

if command -v go > /dev/null 2>&1; then
    # gofmt is bundled with the Go distribution — missing gofmt means a broken install.
    _go_ver=$(go version 2>/dev/null | grep -oE 'go[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1 | sed 's/^go//')
    _info "go $_go_ver"
    if command -v gofmt > /dev/null 2>&1; then
        _ok "gofmt  (bundled with go, $(command -v gofmt))"
    else
        _warn "gofmt  (not found — should be bundled with Go; check your Go install)"
    fi
    unset _go_ver
fi

_check_optional \
    "goimports  (null-ls formatter: Go import organizer)" \
    "goimports" \
    "go install golang.org/x/tools/cmd/goimports@latest"

_check_optional \
    "golines  (null-ls formatter: Go line-length enforcer)" \
    "golines" \
    "go install github.com/segmentio/golines@latest"

# ── Rust ──────────────────────────────────────────────────────────────────────

_section "Rust"

_check_recommended \
    "rustup  (manages rust-analyzer installation and toolchains)" \
    "rustup" \
    "$(_pkgcmd rustup rustup)"

_check_recommended \
    "cargo  (Rust package manager and build tool)" \
    "cargo" \
    "$(_pkgcmd rustup rustup)"

# ── C / C++ ───────────────────────────────────────────────────────────────────

_section "C / C++"

_check_recommended \
    "clang-format  (null-ls formatter: C/C++, uses .clang-format style files)" \
    "clang-format" \
    "$(_pkgcmd clang-tools llvm)"

_check_recommended \
    "cppcheck  (null-ls linter: C/C++ static analysis, C++20)" \
    "cppcheck" \
    "$(_pkgcmd cppcheck cppcheck)"

# ── Python formatters ─────────────────────────────────────────────────────────

_section "Python formatters"

_check_optional \
    "black  (null-ls formatter: Python)" \
    "black" \
    "pip install black"

_check_optional \
    "isort  (null-ls formatter: Python import sorter)" \
    "isort" \
    "pip install isort"

# ── Markdown ──────────────────────────────────────────────────────────────────

_section "Markdown"

_check_recommended \
    "markdownlint  (null-ls linter: Markdown style checker)" \
    "markdownlint" \
    "$(_pkgcmd nodePackages.markdownlint-cli markdownlint-cli)"

# markdownlint config — only relevant when markdownlint is installed.
# null-ls passes -r ~/.markdownlint.yaml; without it, markdownlint uses built-in defaults.
if command -v markdownlint > /dev/null 2>&1; then
    _ml_cfg="$HOME/.markdownlint.yaml"
    if [[ -f $_ml_cfg ]]; then
        _ok "~/.markdownlint.yaml  ($_ml_cfg)"
    else
        _warn "~/.markdownlint.yaml  (not found — markdownlint will use built-in defaults)"
        if (( DRYRUN )); then
            _info "Would offer to create: $_ml_cfg"
        else
            printf '  Create a default ~/.markdownlint.yaml? [y/N] '
            local _ml_ans
            read -r _ml_ans
            if [[ ${_ml_ans:l} == y ]]; then
                cat > "$_ml_cfg" <<'YAML'
# ~/.markdownlint.yaml
# Reference: https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md
default: true
MD013: false   # line-length (off for code-heavy docs)
MD033: false   # inline HTML
YAML
                _ok "Created $_ml_cfg"
                (( WARN-- ))
            fi
        fi
    fi
    unset _ml_cfg _ml_ans
fi

# ── Terminal font ─────────────────────────────────────────────────────────────

_section "Terminal"

_info "Nerd Font: cannot be verified programmatically."
_info "Ensure your terminal uses a Nerd Font — see https://nerdfonts.com"
_info "Required for icons in lualine, nvim-tree, bufferline, and lightbulb."

# =============================================================================
# Summary
# =============================================================================

printf '\n%s── Summary ──%s\n' "$C_BOLD" "$C_RESET"
printf '%s✓%s  %d passed\n' "$C_GREEN"  "$C_RESET" "$PASS"
(( WARN > 0 )) && printf '%s⚠%s  %d warning(s)\n' "$C_YELLOW" "$C_RESET" "$WARN"
(( FAIL > 0 )) && printf '%s✗%s  %d failed\n'     "$C_RED"    "$C_RESET" "$FAIL"

if (( FAIL == 0 )); then
    printf '\n%sPASSED%s — all required tools are present.\n' "$C_GREEN$C_BOLD" "$C_RESET"
    (( WARN > 0 )) && printf 'Note: optional formatters above are missing; formatting is skipped for those file types.\n'
    (( DRYRUN ))   && printf '(dry run — nothing was installed)\n'
    exit 0
else
    printf '\n%sFAILED%s — %d required tool(s) missing. Install them and re-run.\n' \
        "$C_RED$C_BOLD" "$C_RESET" "$FAIL"
    exit 1
fi
