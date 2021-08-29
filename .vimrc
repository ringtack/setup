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

" Source local .vimrc if it exists; prevents shell commands from executing
set exrc
set secure

" enable clicking and scrolling as expected
set mouse+=a

" have backspace work normally in insert mode
set backspace=indent,eol,start

" set leader key to comma
let mapleader = ","
" set localleader key to same key as leader
let maplocalleader = ","

" set number of visual spaces per tab character
set tabstop=2
set shiftwidth=2

" use spaces for tabs
" set softtabstop=2
set expandtab

" show relative line number
set number
set relativenumber
highlight LineNr ctermfg=black

" change sign column place and highlight
" autocmd VimEnter * set scl=auto
" autocmd VimEnter * highlight SignColumn ctermbg=none

" highlight current line
" set cursorline

" visual autocomplete for command menu
set wildmenu

" allow easy split creation
nnoremap <leader>d : sp<CR>
nnoremap <leader>r : vsp<CR>

" allow easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" easily open location list for errors
nnoremap <C-D> :CocDiagnostics<CR>

" redraw only when we need to (not in the middle of macros)
set lazyredraw

" highlight matching [{()}]
" set showmatch

" we don't want autocomplete preview in scratch window
set completeopt-=preview

" Disable the default Vim startup message
set shortmess+=I

" always show status line at the bottom
set laststatus=2
" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

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

" Set auto-indenting on for programming
set ai
" Enable smart indenting (is this even necessary)
set si
" Enable C-indent
set cindent
" Enable most cracked indenting i guess
set indentexpr=cindent



" Enable softwrapping
set wrap linebreak nolist
" Enable hard wrapping at n
set textwidth=100

" Create a vertical bar from 81-end
" let &colorcolumn=join(range(81,999),",")

" Create a vertical column at n
set colorcolumn=100
hi ColorColumn ctermbg=0x545C58



" Change the cursor shape
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Enable cursor guide only in Vim
let &t_ti.="\<Esc>]1337;HighlightCursorLine=true\x7"
let &t_te.="\<Esc>]1337;HighlightCursorLine=false\x7"

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

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


" LaTeX support
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'

" Snippets plugin
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" Distraction-free Vim editing
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'

" Highlight indented lines
Plug 'yggdroot/indentline'

" Git blamer
Plug 'APZelos/blamer.nvim'

" Git & GitHub support
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" File explorer
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons' 

" Nerdtree git support
Plug 'Xuyuanp/nerdtree-git-plugin'

" Display git changes in files
Plug 'airblade/vim-gitgutter'

" Change status bar
" Note: this requires additional Font installation, see
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Easier commenting
Plug 'preservim/nerdcommenter'

" Format tables/equations/etc
Plug 'godlygeek/tabular'

" HTML/CSS support for tags
Plug 'mattn/emmet-vim'
" Emmet Web API
Plug 'mattn/webapi-vim'

" Rename HTML/XML tags
Plug 'AndrewRadev/tagalong.vim'
" Javascript support
" Plug 'pangloss/vim-javascript'
" Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'jelera/vim-javascript-syntax'
Plug 'othree/javascript-libraries-syntax.vim'

""" C/C++ support """
" Quick header/code swapping
Plug 'vim-scripts/a.vim'

""" Solidity Support """
Plug 'TovarishFin/vim-solidity'
Plug 'sohkai/syntastic-local-solhint'

" Advanced syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'


" Rust support
Plug 'rust-lang/rust.vim'

" Golang support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Auto Pairs
Plug 'jiangmiao/auto-pairs'

" Track time on Vim
Plug 'wakatime/vim-wakatime'

" Autoformat files
Plug 'mitermayer/vim-prettier', { 'do': 'yarn install' }

" Allows customization of editor
Plug 'editorconfig/editorconfig-vim'

" IntelliSense support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Async Linting
Plug 'dense-analysis/ale'

" Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

call plug#end()




" activates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax enable




" VIM-SURROUND CONFIG
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"




" VIMTEX CONFIG
set rtp+=~/current_course
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
au Filetype tex setl conceallevel=0
" let g:tex_conceal='abdmg'
" let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
" let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"

" Latex specification, to prevent sluggish UI
au BufNewFile,BufRead *.tex
    \ set nocursorline |
    \ set nornu |
    \ set number |
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




" LIMELIGHT/GOYO CONFIG

" easy enable/disable
nnoremap <leader>gy :call GoyoToggle()<cr>

function! GoyoToggle()
    if exists('#goyo')
     	Goyo!
    else
		Goyo
    endif
endfunction

" set dimmed color for limelight
let g:limelight_conceal_ctermfg = 'gray'

" enable Limelight on entering Goyo,
" get rid of weird carrot line at bottom
" get rid of cursorline in Goyo
" quit Goyo and vim together
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  hi StatusLineNC ctermfg=white
  Limelight
  set nocursorline
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  Limelight!
" set cursorline
  AirlineToggle
  AirlineToggle
  AirlineRefresh
  highlight LineNr ctermfg=black
	hi ColorColumn ctermbg=0x545C58
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()




" INDENTLINE CONFIG
let g:indentLine_enabled=1
let g:indentLine_conceallevel=2
let g:indentLine_concealcursor='inc'
let g:indentLine_char_list=['|', '¦', '┆', '┊']

" Maintain normal conceal levels for other plugins
let g:indentLine_setConceal=0



" BLAMER.NVIM CONFIG

" make blamer faster and grey colored
highlight Blamer guifg=lightgrey
let g:blamer_delay = 150
let g:blamer_enabled = 0
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0 
nnoremap <leader>b : call BlamerToggle()<cr>




" VIM FUGITIVE CONFIG

" Easy status
nmap <leader>gs :G<CR>

" better diff management (useful when managing merges with vim-fugitive)
nmap d2 :diffget //2<Cr>
nmap d3 :diffget //3<Cr>




" EMMET CONFIG

" How to use: https://docs.emmet.io/abbreviations/syntax/
" install only for HTML/CSS files
let g:user_emmet_install_global = 0
autocmd FileType html,css,javascript,javascript.jsx,typescript,typescript.tsx EmmetInstall


let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" set lead key to ',' (so we can use ',,' to trigger emmet)
let g:user_emmet_leader_key = ','




" TAGALONG CONFIG

" We want tagalong to notify us when it changes a tag
let g:tagalong_verbose = 1




" NERDTREE CONFIG

" We want to open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" More configs
" autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeWinSize=25


" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif




" NERDCOMMENTER CONFIG

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Remove 'Press ? for help'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


" TABULAR CONFIG

if exists(":Tabularize")
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:\zs<CR>
      vmap <Leader>a: :Tabularize /:\zs<CR>
			nmap <Leader>a| :Tabularize /|<CR>
			vmap <Leader>a| :Tabularize /|<CR>
	  	nmap <Leader>a& :Tabularize /&<CR>
	  	vmap <Leader>a& :Tabularize /&<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction




" AIRLINE CONFIG

" Tell airline we installed a patched font so it displays correctly
let g:airline_powerline_fonts = 1

" Setup theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" use airline's tabline too
let g:airline#extensions#tabline#enabled = 1

" remove separators for empty sections
let g:airline_skip_empty_sections = 1

" disable spell detection
let g:airline_detect_spell=0




" Auto Pairs
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '"""':'"""', "'''":"'''"}
" let g:AutoPairsShortcutFastWrap='<leader>w'
" imap <leader>w: <M-e>




" C/C++ Syntax Highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1





" RUST CONFIG

" Format on save
let g:rustfmt_autosave = 1

" set tab width to 4 for Rust files
au Filetype rust setl ts=4 sw=4




" GO CONFIG

" Set default formatter to gofmt
let g:go_fmt_command = "goimports"

" Go code highlighting
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" Enable highlighting of same variables
let g:go_auto_sameids = 1

" Show type info in line
let g:go_auto_type_info = 1

" Reuse terminal window
let g:go_term_reuse = 1




" GOTAGS CONFIG
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }
set tags=tags;/




" FZF CONFIG

" Floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4 } }

" Search files with Ctrl-p
map <C-p> :GFiles<CR>

" Search files with Ctrl-o
" map <C-o> :Files<CR>

" Search buffers with Ctrl-i
" map <C-i> :Buffers<CR>

" Search directory of current file with Ctrl-u
map <C-u> :FZF %:p:h<CR>

" Search commands with Ctrl-i
map <C-t> :Commands<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1




" CoC CONFIG (copied from repo "neoclide/coc.nvim")

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <Down>
    \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <C-j> <Down>
inoremap <C-k> <Up>


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>




" ALE CONFIG

" Keybinds for navigating errors
nmap <silent> <leader>j :ALENextWrap<cr>
nmap <silent> <leader>k :ALEPreviousWrap<cr>

" Keybind for :ALEFix 
nmap <leader>p :ALEFix<cr>

" Enable ALE completion
" let g:ale_completion_enabled = 1


" Set linters for different file types
let g:ale_linters = {
 \ 'rust': ['rustc', 'rls'],
 \ 'tex': ['chktex', 'lacheck']
 \ }


" Set fixers for different file types
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint'],
 \ 'javascriptreact': ['prettier', 'eslint'],
 \ 'typescript': ['prettier', 'eslint'],
 \ 'typescriptreact': ['prettier', 'eslint'],
 \ 'json': ['prettier'],
 \ 'c': ['clang-format'],
 \ 'cpp': ['clang-format'],
 \ 'rust' : ['rustfmt'],
 \ 'go': ['gofmt'],
 \ 'python': ['isort', 'autopep8'],
 \ 'tex': ['latexindent'],
 \ 'markdown': ['pandoc']
 \ }

" Enable fix on save
let g:ale_fix_on_save = 1

" Enable compatibility with Coc
" let g:ale_disable_lsp = 1

" Enable compatibility with vim-airline
let g:airline#extensions#ale#enabled = 1


" Customize linting highlights
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '' " Warning symbol (U+26A0) ⚠
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEError ctermbg=NONE
highlight ALEWarning ctermbg=NONE

" Enable hover balloons
" let g:ale_set_balloons=1

" Always enable side gutter
" let g:ale_sign_column_always = 1




" PRETTIER CONFIG

" nnoremap <silent> <leader>p :<C-u>CocCommand prettier.formatFile<cr>
" command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:Prettier = '<nop>'

" Format on Save settings; makes it slow ResidentSleeper
" https://github.com/ctaylo21/jarvis/blob/master/config/nvim/coc-settings.json

let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'true'
let g:prettier#config#arrow_parens = 'always'
let g:prettier#config#trailing_comma = 'all'

let g:prettier#autoformat_require_pragma = 0

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0

" enable format on save, I think?
autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync





" ================================= "
" === Base Vim Highlight Groups === "
" ================================= "

" Javascript highlighting
hi Operator ctermfg=magenta

" VimTex Conceal highlighting
autocmd VimEnter * hi Conceal ctermfg=cyan ctermbg=none cterm=bold
