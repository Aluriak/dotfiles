" Plugins management with junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Languages forge
        " prolog support
                Plug 'mndrix/prolog.vim'
        " ASP support
                Plug 'aluriak/asp.vim'
        " Ada support
                Plug 'ada.vim', { 'for': 'ada' }
        " Haskell syntax support
                Plug 'vim-scripts/haskell.vim'
        " python
                Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
                Plug 'vim-scripts/python_match.vim', { 'for': 'python' }
        " latex
                Plug 'lervag/vimtex', { 'for': 'tex' }
        " sparql
                Plug 'rvesse/vim-sparql', { 'for': 'sparql' }
" features
        " subvertion with {} and coercition
                Plug 'aluriak/vim-abolish'
        " quick opening/manipulation of header + source files
                Plug 'fanchangyong/a.vim'
        " quick line commenting
                Plug 'aluriak/nerdcommenter'
        " simple and efficient search of files in project
                Plug 'kien/ctrlp.vim'
        " quick motions with f, t and others
                Plug 'Lokaltog/vim-easymotion'
        " indented lines as text objects
                Plug 'michaeljsmith/vim-indent-object'
        " git support: commit in vim + gitconfig indent and syntax + commit browser
                Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim' | Plug 'tpope/vim-git'
                Plug 'airblade/vim-gitgutter'
                Plug 'int3/vim-extradite', { 'on':  'Extradite' }
        " save and reuse named macros
                Plug 'chamindra/marvim'
        " multiple cursor edition
                Plug 'terryma/vim-multiple-cursors'
        " complementation (synergies: vimshell)
                Plug 'Shougo/neocomplcache.vim'
        " snippets (synergies: neocomplcache)
                Plug 'Shougo/neosnippet'
                Plug 'Shougo/neosnippet-snippets'
        " tabs and file tree
                Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
                Plug 'jistr/vim-nerdtree-tabs'
        " improved search
                Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
        " improve make session management
                Plug 'tpope/vim-obsession'
        " preview the registers
                Plug 'junegunn/vim-peekaboo'
        " rainbow parenthesis
                Plug 'junegunn/rainbow_parentheses.vim'
        " . repeat whole maps
                Plug 'tpope/vim-repeat'
        " bookmarks (signatures)
                Plug 'kshenoy/vim-signature'
        " replacements by cycles
                Plug 'AndrewRadev/switch.vim'
        " syntax checker
                Plug 'scrooloose/syntastic'
                Plug 'myint/syntastic-extras'
        " alignment of line
                Plug 'orbisvicis/tabular'
        " liste des fonctions/variables
                "Plug 'taglist.vim'
                Plug 'majutsushi/tagbar'
        " Terminal in vim
                Plug 'Shougo/vimproc.vim', { 'do': 'make' } | Plug 'Shougo/vimshell.vim', { 'on': 'VimShellTab' }
        " improve the * find and search
                Plug 'bronson/vim-visual-star-search'

" fluff
        " coloured and efficient HUI + themes
                Plug 'vim-airline/vim-airline'
                Plug 'vim-airline/vim-airline-themes'
        " colorscheme
                Plug 'blueyed/vim-colors-solarized'
        " tabulation mark
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
                Plug 'mhinz/vim-randomtag'
        " csv file commands and visual helps
                "Plug 'chrisbra/csv.vim', { 'for': 'csv' }
" unused
        " scala support  (yes, a day i will code in scala)
                "Plug 'derekwyatt/vim-scala'
                "Plug 'ktvoelker/sbt-vim'
                "Plug 'mdreves/vim-scaladoc'
        " better buffer closing management
                "Plug 'moll/vim-bbye'
        " stacking of the yanked data: UNUSABLE: overwrite remapping of ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']
                "Plug 'maxbrunsfeld/vim-yankstack'
        " colorscheme, reminds Don't Starve
                "Plug 'AlessandroYorba/Alduin'
" usable
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




" setup: leader
let mapleader = "\<space>"

" setup: abbreviations
cabbrev actual source ~/.vimrc
cabbrev tq tabclose

" setup: conceal (no conceal at all, especially in latex)
set conceallevel=0
let g:tex_conceal= ''

" setup: indentation
set shiftwidth=4        "indentation = N cases
set smarttab            "chevrons équivalent à la touche tab
set nu                  "affichage des numéros de ligne
set autoindent          "indentation gardée après saut de ligne
set expandtab           "pas de tab, uniquement des espaces

" setup: list characters
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

" setup: shortcuts
" line focus: zz for center active line, zb for put it at the bottom
" and zt for put it at the top.
" this remapping is necessary because of the bépo remapping.
noremap zt zt
" map escape to çç:
noremap! çç <ESC>
" enable ragequit
cnoreabbrev Q q
" paste on next line at the right level of indentation, then pass in insert mode.
nmap <Leader>o o?<ESC>PAççxa

" setup: options on behavior
set nomodeline          " security about modelines
set cm=blowfish         " Encryption : use of Blofish algorithm
set pastetoggle=<F10>   " Use <F10> to toggle between 'paste' and 'nopaste'
set wildmenu            " Better command-line completion
set cursorline          " Line where cursor is, is highlighted
set lazyredraw          " redraw only when we need to.
set scrolloff=1         " let always one line after & before the cursor


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

"set cursorcolumn
highlight CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=None
set nofoldenable " no weird and unefficient folding

" session manager have the default comportement, except that is not save the
" local and global mappings/options.
" not that these behavior is improved by tpope/vim-obsession
set sessionoptions=blank,folds,sesdir,help,tabpages,winpos,winsize

" setup: NERDTree (+ nerdtree tabs)
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
let g:airline#extensions#tabline#enabled = 1  " good-looking tabs
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

" setup: alduin  (colorscheme)
" replaces the Dark Red to Soft Red
"let g:alduin_Shout_Windhelm = 1
"colorscheme alduin

" setup: ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_working_path_mode = 'ra'   " search in the whole project directory
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_switch_buffer = 'Et'   " if file is already open in a tab, jump to it.
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.vim/plugins_data/ctrlp/'
" use the silver searcher (ag)
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" setup: gitgutter
" whitespace changes are not showed
let g:gitgutter_diff_args = '-w'
let g:gitgutter_realtime  = 0

" setup: marvim
let g:marvim_store = '/home/lucas/.vim/plugins_data/marvim/'
let g:marvim_find_key = '<Leader>m'
let g:marvim_store_key = '<Leader><S-m>'
"let g:marvim_register = 'c'    " change used register from 'q' to 'c'
let marvim_prefix = 0           " disable default syntax based prefix

" setup: multiple cursors :
let g:multi_cursor_exit_from_insert_mode = 0 " don't quit with escape in insert mode
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" setup: rainbow_parentheses
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
" List of colors that you do not want. ANSI code or #RRGGBB
"let g:rainbow#blacklist = [233, 234]
" activate it. For deactivate, add a '!' to the command.
au VimEnter * RainbowParentheses

" setup: snippets
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                        \ "\<Plug>(neosnippet_expand_or_jump)"
                        \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                        \ "\<Plug>(neosnippet_expand_or_jump)"
                        \: "\<TAB>"
" For snippet_complete marker.

" setup: status line
set statusline=%{fugitive#statusline()}\ %{ObsessionStatus('[Obsession]','[Session]')}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" setup: syntastic
nmap <Leader>ss :SyntasticCheck<cr>
nmap <Leader>st :SyntasticToggleMode<cr>
nmap <Leader>sc :lprevious<cr>
nmap <Leader>sr :lnext<cr>
nmap <Leader>se :Errors<cr>
nmap <Leader>sq :SyntasticReset<cr>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_make_checkers = ['gnumake']
let g:syntastic_gitcommit_checkers = ['language_check']
let g:syntastic_svn_checkers = ['language_check']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cursor_column = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_auto_jump = 3 " only jump to errors
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
" error in source code highlighted in blue
highlight SyntasticError        ctermbg=None ctermfg=None
highlight SyntasticWarning      ctermbg=None ctermfg=None
" sign in sign column are in red and yellow
highlight SyntasticErrorSign    cterm=bold ctermbg=None ctermfg=red
highlight SyntasticWarningSign  cterm=bold ctermbg=None ctermfg=yellow

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

" setup: vimtex
let g:vimtex_mappings_enabled = 0
let g:vimtex_latexmk_background = 1
let g:vimtex_quickfix_autojump = 1
let g:vimtex_view_general_viewer = 'evince'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_fold_enabled = 0
let g:vimtex_syntax_minted = [
      \ { 'lang' : 'c', },
      \ { 'lang' : 'cpp', },
      \ { 'lang' : 'python', },
      \]
map <leader>ll <plug>(vimtex-compile-toggle)
map <leader>ls <plug>(vimtex-view)
map <leader>la <plug>(vimtex-%)
map <leader>lu <plug>(vimtex-create-cmd)
map <leader>li <plug>(vimtex-close-env)
map <leader>le <plug>(vimtex-errors)
map <leader>lw <plug>(vimtex-change-env)
map <leader>lc :VimtexWordCount<cr>
" text objects (Environment, delimiter, Paragraph ; exclusive (a) and inclusive (i))
map <leader>lea <plug>(vimtex-ae)
map <leader>lei <plug>(vimtex-ie)
map <leader>lda <plug>(vimtex-ad)
map <leader>ldi <plug>(vimtex-id)
map <leader>lpa <plug>(vimtex-ap)
map <leader>lpi <plug>(vimtex-ip)

" setup: vim-yankstack
"map <leader>y <Plug>yankstack_substitute_older_paste
"map <leader>Y <Plug>yankstack_substitute_newer_paste


" setup: bépo transcription
if !empty(system("setxkbmap -print | grep bepo"))
        source ~/.vimrc.bepo
endif

" déplacement haut-bas
noremap <S-s> 50k
noremap <S-t> 50j
noremap <S-up> 50k
noremap <S-down> 50j

" Fx assigns
noremap <F2> :TagbarToggle<cr>
noremap <F3> :NERDTreeToggle<cr>
noremap <F4> :VimShellTab<cr>
noremap <F6> :Gstatus<cr>
noremap <F7> :Gcommit<cr>
noremap <F9> :VimShellInteractive make<cr>

" paste (before|after) and leave cursor at the beginning
nnoremap œ P`[
nnoremap Œ p`[
" write only one character (before|after) cursor
nnoremap <leader>i i?<Esc>r
nnoremap <leader>a a?<Esc>r

" Modif selon type de fichier
filetype plugin indent on       "Indentation selon extension de fichier (nécessaire pour vundle)
syntax on                       "affichage des couleurs
au BufNewFile,BufRead *.pde setf arduino
au BufNewFile,BufRead *.mkd setf mkd
au BufNewFile,BufRead *.adb setf ada
au BufNewFile,BufRead *.ads setf ada
au BufNewFile,BufRead *.py  setf python
au BufNewFile,BufRead *.tex set encoding=utf-8
au BufNewFile,BufRead *.rb set shiftwidth=2
au BufNewFile,BufRead {M,m}akefile set noexpandtab

" Store temporary files in a central spot
" see here: https://github.com/tpope/vim-obsession/issues/18#issuecomment-69852130
let vimtmp = $HOME . '/.vim/tmp/' . getpid()
silent! call mkdir(vimtmp, "p", 0700)
let &backupdir=vimtmp
let &directory=vimtmp

" setup: neocomplcache settings
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_max_list = 20

" Enable heavy features.
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Use delimiter completion.
let g:neocomplcache_enable_auto_delimiter = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
        return neocomplcache#smart_close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode (Not recommended)
inoremap <expr><Left> neocomplcache#close_popup() . "\<Left>"
inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
inoremap <expr><Up> neocomplcache#close_popup() . "\<Up>"
inoremap <expr><Down> neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup vimrc_autocmds
        autocmd!
        " draw a vertical line at 80 characters
        autocmd FileType python set colorcolumn=81
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" Delete ~/.vim/.netrwhist file after generation
au VimLeave * if filereadable("~/.vim/.netrwhist") | call delete("~/.vim/.netrwhist") | endif

" List all commands in a new buffer. Inspired by
"  http://stackoverflow.com/a/15756785/3077939
"  http://stackoverflow.com/a/2573758/3077939
function! Listmaps()
    :tabnew
    :redir => m | :silent verbose map | redir END | put=m
endfunction
