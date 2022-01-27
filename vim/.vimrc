" WELCOME TO VIMRC
" 
" KEEP 10 EMPTY LINES BETWEEN SECTIONS
" KEEP A SECTION COMMENT FOR EACH SECTION
"  
" HOW TO USE:
" 1. INSTALL VIM (A VERSION THAT SUPPORTS PYTHON)
" 2. INSTALL VIM-PLUG (see https://github.com/junegunn/vim-plug)
" 3. INSTALL PLUGINS THROUGH VIM-PLUG (same link as above)
" 4. LOOK THROUGH THIS FILE AND EACH PLUGIN REPO PAGE TO UNDERSTAND USE CASES
" (repos are listed after "Plug" and are on GitHub)








" GENERAL SECTION

" enable clicking and scrolling as expected
set mouse+=a

" have backspace work normally in insert mode
set backspace=indent,eol,start

" set [local]leader key to comma
let mapleader = ","
" set localleader key to same key as leader
let maplocalleader = ","

" set number of visual spaces per tab character
set tabstop=4
set shiftwidth=4

" use spaces for tabs
set expandtab

" show relative line number
set number
set relativenumber
highlight LineNr ctermfg=darkgray

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to (not in the middle of macros)
set lazyredraw

" Disable the default Vim startup message
set shortmess+=I

" always show status line at the bottom
set laststatus=2

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Highlight search results
set hlsearch
hi Search ctermbg=0x545C58

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Enable smart indenting 
set si


" Enable softwrapping
set wrap linebreak nolist
" Enable hard wrapping at 100
set textwidth=100

" Create a vertical column at 100
set colorcolumn=100
hi ColorColumn ctermbg=0x545C58


" Change the cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=1\x7"

" Enable cursor guide only in Vim
let &t_ti.="\<Esc>]1337;HighlightCursorLine=true\x7"
let &t_te.="\<Esc>]1337;HighlightCursorLine=false\x7"

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Remember meaningful j and k as jumps
nnoremap <expr> k (v:count > 10 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 10 ? "m'" . v:count : '') . 'gj'





" VIM-PLUG SECTION
" see https://github.com/junegunn/vim-plug for use
" automatically downloads vim-plug if not already in system
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Start vim-plug
"
call plug#begin()

" LIST PLUGINS HERE

" add functionality to surround highlighted text
Plug 'tpope/vim-surround'
"
" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" LaTeX support
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', { 'for': 'tex' }

" Snippets plugin
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Highlight indented lines
Plug 'yggdroot/indentline'

" Easier commenting
Plug 'preservim/nerdcommenter'

" light statusline
Plug 'itchyny/lightline.vim'

call plug#end()





" activates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax enable





" VIM-SURROUND CONFIG
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"





" VIMTEX CONFIG

let g:tex_fast = "bMprs"

let g:tex_flavor='latex'

" set pdf viewer to zathura
let g:vimtex_view_method='zathura'

" redirect build files to a build directory
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : 'build',
            \}

" automatically open quickfix window when errors occur, but stop from being the active window
let g:vimtex_quickfix_mode=2

" automatically close quickfix window after 3 keystrokes
let g:vimtex_quickfix_autoclose_after_keystrokes=3

" prevent quickfix window from opening when only warnings are present
let g:vimtex_quickfix_open_on_warning=0

" set Vim filetype to tex
set ft=tex

" set text encoding to utf8
set encoding=utf8
" Enable formatting and syntax highlighting
let g:vimtex_format_enabled=1 
let g:vimtex_syntax_enabled=1

" disable concealing LaTeX symbols; don't like it right now
" au Filetype tex setl conceallevel=0
let g:tex_conceal='abdmg'
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"

" Latex specification, to prevent sluggish UI
" au BufNewFile,BufRead *.tex
    " \ set nocursorline |
    " \ set nornu |
    " \ set number |
    \ let g:loaded_matchparen=1 |





" ULTISNIPS CONFIG
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsListSnippets = '<leader>ls'

" To use spellcheck: <C-l>
setlocal spell
set spelllang=en_us
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
hi SpellBad ctermbg=0x765757





" INDENTLINE CONFIG
let g:indentLine_enabled=1
let g:indentLine_conceallevel=2
let g:indentLine_concealcursor='inc'
let g:indentLine_char_list=['|', '¦', '┆', '┊']

" Maintain normal conceal levels for other plugins
let g:indentLine_setConceal=0





" NERDCOMMENTER CONFIG

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Remove 'Press ? for help'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1





" AUTO PAIRS
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '"""':'"""', "'''":"'''"}
" let g:AutoPairsShortcutFastWrap='<leader>w'
" imap <leader>w: <M-e>





" ================================= "
" === Base Vim Highlight Groups === "
" ================================= "

" VimTex Conceal highlighting
autocmd VimEnter * hi Conceal ctermfg=cyan ctermbg=none cterm=bold
