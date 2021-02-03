" Plugins management with junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Languages forge
        " prolog support
                " Plug 'mndrix/prolog.vim', { 'for': 'prolog' }
        " Ada support  " Raise deprecated error
                " Plug 'ada.vim', { 'for': 'ada' }
        " ASP support
                Plug 'aluriak/asp.vim'
        " Haskell syntax support
                " Plug 'vim-scripts/haskell.vim' { 'for': 'haskell' }
        " racket
                " Plug 'wlangstroth/vim-racket', { 'for': 'racket' }
        " syntax coloration and spaces packs over 100 languages
                Plug 'sheerun/vim-polyglot'
        " python
                Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
                Plug 'vim-scripts/python_match.vim', { 'for': 'python' }
                " Plug 'achimnol/python-syntax', { 'for': 'python' }
                " More powerful, but does not support annotations :(
                " Plug 'vim-python/python-syntax', { 'for': 'python' }
                " Slooooooow
                " Plug 'kh3phr3n/python-syntax', { 'for': 'python' }
        " latex
                " Plug 'lervag/vimtex', { 'for': 'tex' }
        " sparql, rdf
                " Plug 'rvesse/vim-sparql', { 'for': 'sparql' }
                " Use the second when the PR will be merged: https://github.com/niklasl/vim-rdf/pull/3
                " Plug 'aluriak/vim-rdf', { 'for': ['turtle', 'n3', 'trig', 'jsonld'] }
                "Plug 'niklasl/vim-rdf', { 'for': ['turtle', 'n3', 'trig', 'jsonld'] }
        " JSON
                " Plug 'elzr/vim-json', { 'for': 'json' }
        " OpenCL
                " Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
        " Markdown
                " Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown', { 'for': ['mkd', 'md'] }

" features
        " random tag generator
                Plug 'aluriak/vim-deedee'
        " subvertion with {} and coercition
                Plug 'aluriak/vim-abolish'
        " quick opening/manipulation of header + source files
                Plug 'fanchangyong/a.vim'
        " quick line commenting
                Plug 'scrooloose/nerdcommenter'
        " simple and efficient search of files in project
                Plug 'ctrlpvim/ctrlp.vim'
        " quick motions with f, t and others
                Plug 'Lokaltog/vim-easymotion'
        " indented lines as text objects
                Plug 'michaeljsmith/vim-indent-object'
        " git support: commit in vim + gitconfig indent and syntax + commit browser
                " Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim' | Plug 'tpope/vim-git'
                " Plug 'airblade/vim-gitgutter'
                " Plug 'int3/vim-extradite'
        " save and reuse named macros
                Plug 'chamindra/marvim'
        " multiple cursor edition
                Plug 'terryma/vim-multiple-cursors'
        " completion
                Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
                Plug 'zchee/deoplete-jedi', { 'for': 'python' }
                " Plug 'zchee/deoplete-zsh', { 'for': ['sh', 'zsh'] }
                " Plug 'zchee/deoplete-clang'   " to set properly (path to clang)
        " ?
                " Plug 'Shougo/neoinclude.vim'
        " show function signature in command line
                " Plug 'Shougo/echodoc.vim'
        " add closing parenthesis
                " Plug 'Shougo/neopairs.vim'
        " snippets
                Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips'
        " tabs and file tree
                Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
                Plug 'jistr/vim-nerdtree-tabs'
        " improve make session management
                Plug 'tpope/vim-obsession'
        " rainbow parenthesis
                Plug 'junegunn/rainbow_parentheses.vim'
        " . repeat whole maps
                Plug 'tpope/vim-repeat'
        " bookmarks (signatures)
                Plug 'kshenoy/vim-signature'
        " replacements by cycles
                " Plug 'AndrewRadev/switch.vim'
        " alignment of line
                Plug 'orbisvicis/tabular'
        " liste des fonctions/variables
                "Plug 'taglist.vim'
                Plug 'majutsushi/tagbar'
        " Terminal in vim
                " Plug 'Shougo/vimproc.vim', { 'on': 'VimShellTab', 'do': 'make' } | Plug 'Shougo/vimshell.vim', { 'on': 'VimShellTab' }
        " improve the * find and search
                Plug 'bronson/vim-visual-star-search'
        " vim as note taker (:Note and :SearchNote), needing vim-misc by
        "  design and auto_mkdir for automatically create new subdirs
                Plug 'dyng/auto_mkdir' | Plug 'xolox/vim-misc' | Plug 'nicocrm/vim-notes'

" fluff
        " coloured and efficient HUI + themes
                Plug 'vim-airline/vim-airline'
                Plug 'vim-airline/vim-airline-themes'
        " colorscheme
                Plug 'blueyed/vim-colors-solarized'
        " tabulation mark     WARNING: use conceal
                Plug 'Yggdroot/indentLine'
        " automatic line numbering
                Plug 'voanhduy1512/vim-numbertoggle'
" other
        " Tetris game
                "Plug 'vim-scripts/TeTrIs.vim'
        " Rogue game
                "Plug 'katono/rogue.vim'
" à tester
        " github issues
                "Plug 'jaxbot/github-issues.vim'
        " EPUB edition
                "Plug 'etnadji/vim-epub'
        " random tip for learn new things about vim
                " Plug 'mhinz/vim-randomtag'
        " arduino support - compile wihtout needing to open the arduino IDE
                "Plug 'tclem/vim-arduino'
        " csv file commands and visual helps
                "Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" unused
        " colorscheme, reminds Don't Starve
                "Plug 'AlessandroYorba/Alduin'
        " stacking of the yanked data: UNUSABLE: overwrite remapping of ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']
                "Plug 'maxbrunsfeld/vim-yankstack'
        " preview the registers: UNUSABLE: completely interfer with bepo remapping
                "Plug 'junegunn/vim-peekaboo'
        " surround text: UNUSABLE: interfer with bepo remapping
                "Plug 'tpope/vim-surround'
        " improved search: UNUSABLE: completely interfer with bepo remapping
                "Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
" usable
        " syntax checker
                " Plug 'scrooloose/syntastic'
                " Plug 'myint/syntastic-extras'
        " colaborativ vim
                "Plug 'FredKSchott/CoVim'
        " coding style uniformization between multiple IDE
                "Plug 'editorconfig/editorconfig-vim'


" ends plugin settings
call plug#end()




"""""""""""""""""""""""""""""""""""""""""""""
" neobundle initialization terminated
" vimrc begin here
"""""""""""""""""""""""""""""""""""""""""""""




" setup: bépo transcription
if !empty(system("setxkbmap -print | grep bepoz"))
    source ~/.vimrc.bepoz
    let g:keymap = "bepoz"
elseif !empty(system("setxkbmap -print | grep bepo"))
    source ~/.vimrc.bepo
    let g:keymap = "bepo"
else
    let g:keymap = "default"
endif


" setup: leader
let mapleader = "\<space>"

" setup: abbreviations
cabbrev actual source ~/.vimrc
cabbrev tq tabclose

" setup: conceal (no conceal at all, especially in latex)
set conceallevel=0
set concealcursor=""
let g:tex_conceal= ''

" setup: indentation
set expandtab           " no tab, just spaces
set tabstop=4           " how many columns a tab counts for
set shiftwidth=4        " how many columns text is indented with the reindent operations (<< and >>)
set autoindent          " keep indentation after line break
set smarttab            " << and >> are equivalent to tab key
set nu                  " line number

" setup: list characters
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" setup: shortcuts
" map escape to çç:
noremap! çç <ESC>
noremap! ç<ESC> <ESC>
" enable ragequit
cnoreabbrev Q q
" quick opening of tabs
cnoreabbrev Tn tabnew
cnoreabbrev TN tabnew
" paste on next line at the right level of indentation, then pass in insert mode.
nmap <Leader>o o<ESC>PA

" setup: options on behavior
set nomodeline          " security about modelines
set pastetoggle=<F10>   " Use <F10> to toggle between 'paste' and 'nopaste'
set wildmenu            " Better command-line completion
set cursorline          " Line where cursor is, is highlighted
set lazyredraw          " redraw only when we need to.
set scrolloff=1         " let always one line after & before the cursor
set diffopt+=vertical   " diff vertically if screen is large enough
set mouse=              " no mouse support
set cedit=\<C-f>


" setup: easy motion
nmap <Leader>f <Plug>(easymotion-prefix)f
vmap <Leader>f <Plug>(easymotion-prefix)f
nmap <Leader>F <Plug>(easymotion-prefix)F
vmap <Leader>F <Plug>(easymotion-prefix)F
nmap <Leader>j <Plug>(easymotion-prefix)j
vmap <Leader>j <Plug>(easymotion-prefix)j
nmap <Leader>J <Plug>(easymotion-prefix)J
vmap <Leader>J <Plug>(easymotion-prefix)J

" setup: indentline
"let g:indentLine_char = '︙'
let g:indentLine_char = '┆'
let g:indentLine_color_term = 000
let g:indentLine_faster = 1
" conceal is needed by indent line, but markdown files use conceal.
" So, indent in markdown files
autocmd FileType markdown let g:indentLine_concealcursor = ''
autocmd FileType markdown let g:indentLine_conceallevel = 0

"set cursorcolumn
highlight CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=None
set nofoldenable " no weird and unefficient folding

" session manager have the default comportement, except that is not save the
" local and global mappings/options.
" not that these behavior is improved by tpope/vim-obsession
set sessionoptions=blank,folds,sesdir,help,tabpages,winpos,winsize

" setup: nerdcommenter
let g:NERDSpaceDelims = 1  " add space after left token
let g:NERDCustomDelimiters = {'python': { 'left': '#', 'leftAlt': '# ' }}

" setup: nerdtree (+ nerdtree tabs)
nmap <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup=0
let g:nerdtree_tabs_smart_startup_focus=1
let g:nerdtree_tabs_open_on_new_tab=0
let g:nerdtree_tabs_focus_on_files=1

" setup: abolish
cabbrev :S :Subvert
nmap lr <Plug>Coerce

" setup: airline & solarized
let g:airline_powerline_fonts = 1
set noshowmode
"to fix the font and lot of strange characters and colors
set encoding=utf-8
let g:airline_theme='wombat'
set t_Co=256
"set fillchars+=stl:\ ,stlnc:\

" setup: general colorscheme
set background=dark
" color of sign column
highlight SignColumn ctermbg=None ctermfg=white
highlight BookmarkSign ctermbg=None ctermfg=white

" setup: solarized  (colorscheme)
colorscheme solarized
let g:solarized_termcolors=256
let g:solarized_bold      =1
let g:solarized_underline =1
let g:solarized_italic    =1
" high or low or normal values
let g:solarized_contrast  ="high"
let g:solarized_visibility="normal"


" setup: ctrlp
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'a'   " search in the whole project directory
let g:ctrlp_by_filename = 1    " search by filename instead of full path
set wildignore+=*/tmp/*,*.so,*.o,*.pyc,*.swp,*.zip
" if file is already open in a tab, jump to it:  " DOESN'T WORK: see below
let g:ctrlp_switch_buffer = 'ET'
" new tab page opened after current tab page
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.vim/plugins_data/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_path_nolim = 1
" use the silver searcher (ag)
let g:ctrlp_user_command = 'ag %s -f -U -l --nocolor -g ""'
" use this, while the previous ctrlp_switch_buffer option doesn't work:
" on enter, will ask for a new tab. (instead of opening in-place)
" with the option, ctrlp should first search for already opened buffer on
" searched file, but for some reason, it doesn't happen.
" ctrlp_tabpage_position works well, however \o/
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>', '<2-LeftMouse>'],
  \ 'AcceptSelection("t")': ['<cr>'],
  \ }

" setup: deedee
let g:DeedeeSize = 6
let g:DeedeeMode = 'a'
let g:DeedeeAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
noremap <Leader>t :Deedee<cr>

" setup: extradite
let g:extradite_diff_split = 'belowright vertical split'

" setup: gitgutter
" whitespace changes are not showed
let g:gitgutter_diff_args = '-w'
" performances first (only update when saving/opening file)
let g:gitgutter_realtime  = 0
let g:gitgutter_eager = 0
" do not add keymaps yourself
let g:gitgutter_map_keys = 0

" setup: json support
let g:vim_json_syntax_conceal = 0

" setup: markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
" and here the most important feature:
let g:vim_markdown_conceal = 0
" use ```<leftname> to set highlighting of the block to <rightname>
" (works from scratch when <leftname> == <rightname>)
let g:vim_markdown_fenced_languages = ['c++=cpp', 'bash=sh', 'python=py']
let g:vim_markdown_math = 1
noremap <Plug>Markdown_OpenUrlUnderCursor gx


" setup: marvim
let g:marvim_store = $HOME.'/.vim/plugins_data/marvim/'
let g:marvim_find_key = '<leader>m'
let g:marvim_store_key = '<leader><S-m>'
"let g:marvim_register = 'c'    " change used register from 'q' to 'c'
let marvim_prefix = 0           " disable default syntax based prefix

" setup: multiple cursors
let g:multi_cursor_exit_from_insert_mode = 0 " don't quit with escape in insert mode
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" setup: deoplete.nvim
let g:deoplete#sources#jedi#python_path = '/usr/bin/python3.6m'
let g:deoplete#enable_at_startup = 1
" close preview window after completion + get docstring in it
autocmd CompleteDone * silent! pclose!
let g:deoplete#sources#jedi#show_docstring = 1
" Use tab to iter over completions (need ultisnip to not use tab)
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" setup: ultisnip
" do not clash with engine completion by avoiding tab
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-t>"
let g:UltiSnipsJumpBackwardTrigger="<c-s>"
let g:UltiSnipsSnippetsDir="~/.nvim/snippets/"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" setup: vim-notes
let g:notes_smart_quotes = 1
let g:notes_conceal_code = 0
let g:notes_conceal_italic = 0
let g:notes_conceal_bold = 0
let g:notes_conceal_url = 0
let g:notes_smart_quotes = 0
let g:notes_list_bullets = ['•', '▸', '▪', '◦', '▹', '▫']
let g:notes_title_sync = 'rename_file'
let g:notes_suffix = '.vnote'
let g:notes_directories = ['~/notes']
let g:notes_tagsindex = '~/notes/tags'

" setup: kh3phr3n/python-syntax
" let python_self_cls_highlight = 1
" let python_no_operator_highlight = 0
" let python_no_parameter_highlight = 0
" setup: vim-python/python-syntax
" let g:python_highlight_builtins = 1
" let g:python_highlight_builtin_objs = 1
" let g:python_highlight_builtin_funcs = 1
" let g:python_highlight_exceptions = 1
" let g:python_highlight_string_formatting = 1
" let g:python_highlight_string_format = 1
" let g:python_highlight_string_templates = 1
" let g:python_highlight_indent_errors = 1
" let g:python_highlight_space_errors = 1
" let g:python_highlight_doctests = 1
" let g:python_highlight_class_vars = 1
" let g:python_highlight_operators = 1
" let g:python_highlight_all = 1
" let g:python_highlight_file_headers_as_comments = 1
" let g:python_slow_sync = 0
" setup: achimnol/python-syntax
let python_highlight_all = 1
" let g:python_slow_sync = 0

" setup: rainbow_parentheses
let g:rainbow#max_level = 32
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['«', '»']]
" plugin activation (for toggle, add a '!' to the command):
au VimEnter * RainbowParentheses

" setup: status line
set statusline=%{fugitive#statusline()}\ %{ObsessionStatus('[Obsession]','[Session]')}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" setup: switch
nnoremap <Leader>é :Switch<cr>
let b:switch_custom_definitions = [
      \   {
      \     '\<[a-zA-Z_0-9]\+\s*,\s*[a-zA-Z_0-9]\+\>': {
      \       '\([a-zA-Z_0-9]\+\)\(\s*\),\(\s*\)\([a-zA-Z_0-9]\+\)': '\4\2,\3\1'
      \     },
      \   }
      \ ]

" setup: tabular
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>

" setup: tagbar
" nothing to do

" déplacement haut-bas
noremap <S-s> 50k
noremap <S-t> 50j
noremap <S-up> 50k
noremap <S-down> 50j

" Fx assigns
" F1 is assigned to help
noremap <F2> :TagbarToggle<cr>
noremap <F3> :NERDTreeToggle<cr>
noremap <F4> :VimShellTab<cr>
noremap <F5> :Extradite!<cr>
noremap <F6> :Gstatus<cr>
noremap <F7> :Gcommit<cr>
noremap <F9> :VimShellInteractive make<cr>

" paste (before|after) and leave cursor at the beginning
nnoremap œ P`[
nnoremap Œ p`[
" write only one character (before|after) cursor
nnoremap <leader>i i?<Esc>r
nnoremap <leader>a a?<Esc>r

" I don't understand, but it seems powerful.
" https://www.reddit.com/r/neovim/comments/44g53k/multi_cursor_in_neovim/czq5kdd/
nnoremap € :'<,'>g/^/norm
vnoremap € :g/^/norm

" When call macro on multiple lines, ignore those that fail
" instead of stopping the treatment
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Modif selon type de fichier
filetype plugin indent on       "Indentation selon extension de fichier (nécessaire pour vundle)
syntax on                       "affichage des couleurs
au BufNewFile,BufRead *.pde setf arduino
au BufNewFile,BufRead *.mkd setf markdown
au BufNewFile,BufRead *.adb setf ada
au BufNewFile,BufRead *.ads setf ada
au BufNewFile,BufRead *.py  setf python
au BufNewFile,BufRead *.lp  setf prolog
au BufNewFile,BufRead *.tex set encoding=utf-8
au BufNewFile,BufRead *.rb set shiftwidth=2
au BufNewFile,BufRead {M,m}akefile set noexpandtab
au BufReadPost *.rkt,*.rktl set filetype=scheme
au filetype racket set lisp

" python files: draw a vertical line at 80 characters
augroup vimrc_autocmds
        autocmd!
        autocmd FileType python set colorcolumn=81
augroup END

" Store temporary files in a central spot
" see here: https://github.com/tpope/vim-obsession/issues/18#issuecomment-69852130
let vimtmp = $HOME . '/.vim/tmp/' . getpid()
silent! call mkdir(vimtmp, "p", 0700)
let &backupdir=vimtmp
let &directory=vimtmp


" Delete ~/.vim/.netrwhist file after generation
au VimLeave * if filereadable("~/.vim/.netrwhist") | call delete("~/.vim/.netrwhist") | endif

" List all commands in a new buffer. Inspired by
"  http://stackoverflow.com/a/15756785/3077939
"  http://stackoverflow.com/a/2573758/3077939
function! Listmaps()
    :tabnew
    :redir => m | :silent verbose map | redir END | put=m
endfunction
