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
                Plug 'kh3phr3n/python-syntax', { 'for': 'python' }
        " latex
                Plug 'lervag/vimtex', { 'for': 'tex' }
        " sparql
                Plug 'rvesse/vim-sparql', { 'for': 'sparql' }
                Plug 'aluriak/vim-rdf', { 'for': ['turtle', 'n3', 'trig', 'jsonld'] }
        " JSON
                Plug 'elzr/vim-json', { 'for': 'json' }
        " OpenCL
                Plug 'petRUShka/vim-opencl', { 'for': 'opencl' }
" features
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
                Plug 'tpope/vim-fugitive' | Plug 'junegunn/gv.vim' | Plug 'tpope/vim-git'
                Plug 'airblade/vim-gitgutter'
                Plug 'int3/vim-extradite'
        " save and reuse named macros
                Plug 'chamindra/marvim'
        " multiple cursor edition
                Plug 'terryma/vim-multiple-cursors'
        " complementation
                Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py' }
        " snippets (synergies: YouCompleteMe)
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
        " vim as note taker (:Note and :SearchNote), needing vim-misc by
        "  design and auto_mkdir for automatically create new subdirs
                Plug 'dyng/auto_mkdir' | Plug 'xolox/vim-misc' | Plug 'nicocrm/vim-notes'

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
        " improved search: UNUSABLE: completely interfer with bepo remapping
                "Plug 'junegunn/vim-pseudocl' | Plug 'junegunn/vim-oblique'
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
set softtabstop=4       "number of space to move back one indent level
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
noremap! ç<ESC> <ESC>
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
set diffopt+=vertical   " diff vertically if screen is large enough


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

" setup: alduin  (colorscheme)
" replaces the Dark Red to Soft Red
"let g:alduin_Shout_Windhelm = 1
"colorscheme alduin

" setup: ctrlp
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'a'   " search in the whole project directory
let g:ctrlp_by_filename = 1    " search by filename instead of full path
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" if file is already open in a tab, jump to it:
let g:ctrlp_switch_buffer = 'ET'
" new tab page opened after current tab page
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.vim/plugins_data/ctrlp/'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_open_new_file = 'v'
" use the silver searcher (ag)
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" setup: extradite
let g:extradite_diff_split='belowright vertical split'

" setup: gitgutter
" whitespace changes are not showed
let g:gitgutter_diff_args = '-w'
let g:gitgutter_realtime  = 0

" setup: json support
let g:vim_json_syntax_conceal = 0

" setup: marvim
let g:marvim_store = $HOME.'/.vim/plugins_data/marvim/'
let g:marvim_find_key = '<leader>m'
let g:marvim_store_key = '<leader><S-m>'
"let g:marvim_register = 'c'    " change used register from 'q' to 'c'
let marvim_prefix = 0           " disable default syntax based prefix

" setup: multiple cursors :
let g:multi_cursor_exit_from_insert_mode = 0 " don't quit with escape in insert mode
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" setup: vim-notes
let g:notes_smart_quotes = 1
let g:notes_conceal_code = 0
let g:notes_conceal_italic = 0
let g:notes_conceal_bold = 0
let g:notes_conceal_url = 0
let g:notes_list_bullets = ['•', '▸', '▪', '◦', '▹', '▫']
let g:notes_title_sync = 'rename_file'
let g:notes_suffix = '.vnote'
let g:notes_directories = ['~/notes']

" setup: python-syntax
let python_self_cls_highlight = 1
let python_no_operator_highlight = 0
let python_no_parameter_highlight = 0

" setup: rainbow_parentheses
let g:rainbow#max_level = 32
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}'], ['«', '»']]
" plugin activation (for toggle, add a '!' to the command):
au VimEnter * RainbowParentheses

" setup: snippets
let g:UltiSnipsExpandTrigger = '<C-k>'
let g:UltiSnipsJumpForwardTrigger = '<C-k>'
let g:UltiSnipsJumpBackwardTrigger = '<C-e>'
let g:UltiSnipsEditSplit = "vertical"
let g:ultisnips_python_style = "normal"

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

" setup: vim-yankstack  (UNUSED)
"map <leader>y <Plug>yankstack_substitute_older_paste
"map <leader>Y <Plug>yankstack_substitute_newer_paste

" setup: youcompleteme
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


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
