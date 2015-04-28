if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'



" MY BUNDLES HERE :
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Languages forge
        " prolog support
		NeoBundle 'mndrix/prolog.vim'
        " ASP support
                NeoBundle 'aluriak/asp.vim'
        " Ada support
		NeoBundle 'ada.vim'
        " markdown support
                NeoBundle 'tpope/vim-markdown'
" features
        " liste des fonctions/variables
		NeoBundle 'taglist.vim'
        " powerful file explorator (need unite)
		NeoBundle 'Shougo/vimfiler.vim'
        " commenter des portions de code à la volée
		NeoBundle 'aluriak/nerdcommenter'
        " support de git
		NeoBundle 'tpope/vim-fugitive'
        " multiple line insertion
		NeoBundle 'terryma/vim-multiple-cursors'
        " complementation (synergies: vimshell, unite)
		NeoBundle 'Shougo/neocomplcache.vim'
        " complete abbreviations and research
                NeoBundle 'tpope/vim-abolish'
        " vim bookmarks
		NeoBundle 'MattesGroeger/vim-bookmarks'
        " snippets
                NeoBundle 'Shougo/neosnippet'
                NeoBundle 'Shougo/neosnippet-snippets'
        " . repeat whole maps
		NeoBundle 'tpope/vim-repeat'
        " necessary for efficiency Unite, with options for automatize compilation
		NeoBundle 'Shougo/vimproc.vim', {
                        \ 'build' : {
                        \     'windows' : 'tools\\update-dll-mingw',
                        \     'cygwin' : 'make -f make_cygwin.mak',
                        \     'mac' : 'make -f make_mac.mak',
                        \     'linux' : 'make',
                        \     'unix' : 'gmake',
                        \    },
                        \ }
        " powerful finder of whatever you want
		NeoBundle 'Shougo/unite.vim'
        " Terminal in vim (need Unite)
		NeoBundle 'Shougo/vimshell.vim'
        " powerful status line
                NeoBundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" other
        " Tetris game
		"NeoBundle 'vim-scripts/TeTrIs.vim'         
        " Rogue game
		"NeoBundle 'katono/rogue.vim'
" à tester
        " github issues
		"NeoBundle 'jaxbot/github-issues.vim'
        " EPUB edition
                "NeoBundle 'etnadji/vim-epub'
        " random tip for learn new things about vim
                "Neobundle 'mhinz/vim-randomtag'
        " efficient motions
                "NeoBundle 'Lokaltog/vim-easymotion'
" unused
        " powerful research " UNCOMPREHENSIBLE
		"NeoBundle 'mileszs/ack.vim'
        " scala support " yes, a day i will code in scala
                "NeoBundle 'derekwyatt/vim-scala'
                "NeoBundle 'ktvoelker/sbt-vim'
                "NeoBundle 'mdreves/vim-scaladoc'
" usable 
        " colaborativ vim
                "NeoBundle 'FredKSchott/CoVim'



call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleClean
NeoBundleCheck



" initialisation of vundle is terminate
" vimrc begin here



"""""""""
" VIMRC "
"""""""""
" pour que l'indentation avec tab soit la même qu'avec les chevrons
set shiftwidth=8        "indentation = N cases
set smarttab            "chevrons équivalent à la touche tab
set nu                  "affichage des numéros de ligne
set autoindent          "indentation gardée après saut de ligne
set expandtab           "pas de tab, uniquement des espaces

" important details
set nomodeline " security about modelines


" Affichage de la barre de statut, et ?
set statusline=%{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
set laststatus=2


" session manager have the default comportement, except that is not save the
" local and global mappings/options.
set sessionoptions=blank,buffers,sesdir,winpos,folds,help,tabpages,winsize


" SuperTab
"let g:SuperTabNoCompleteAfter=['^', '\s', ',', ' ']
"let g:SuperTabMappingTabLiteral='<c-e>'

" Encryption : use of Blofish algorithm
set cm=blowfish  

" Abolish
abbreviate Subvert S
nmap lr <Plug>Coerce

" Remap and shortcuts for vim-bookmarks
nmap ®® <Plug>BookmarkToggle
nmap ®i <Plug>BookmarkAnnotate
nmap ®o <Plug>BookmarkAnnotate TODO<cr>
nmap ®a <Plug>BookmarkShowAll
nmap ®þ <Plug>BookmarkNext
nmap ®ß <Plug>BookmarkPrev
nmap ®c <Plug>BookmarkClear
nmap ®x <Plug>BookmarkClearAll
let g:bookmark_auto_save_file="/home/lucas/.vim/vim-bookmarks"
"Enables line centering when jumping to bookmark
let g:bookmark_center = 1 
"color of sign column 
highlight SignColumn ctermbg=black   


" vimfiler module definitions
let g:vimfiler_as_default_explorer = 1


" For multiple cursors :
let g:multi_cursor_exit_from_insert_mode = 0 " don't quit with escape in insert mode
let g:multi_cursor_next_key='<C-n>' 
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Unite
nnoremap <C-f> :Unite file_rec/async<cr>
nnoremap <space>/ :Unite grep:.<cr>



" Snippets
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
if has('conceal')
        set conceallevel=2 concealcursor=i
endif



" remappages importants
let mapleader = ","
" bépo transcription
if !empty(system("setxkbmap -print|grep bepo"))
        source ~/.vimrc.bepo
endif

"Abbréviations d'ordre générales
ab actual source ~/.vimrc
ab tq tabclose


" déplacement haut-bas
noremap <S-s> 50k
noremap <S-t> 50j
noremap <S-up> 50k
noremap <S-down> 50j

" Fx assigns
noremap <F1> :TlistToggle<cr> 
noremap <F2> :VimFilerBuffer<cr> 
noremap <F4> :VimShellTab<cr>
noremap <F6> :Gstatus<cr> 
noremap <F7> :Gcommit<cr> 
noremap <F9> :VimShellInteractive make<cr>

" paste (before|after) and leave cursor at the beginning 
noremap œ P`[
noremap Œ p`[
" write only one character (before|after) cursor [DONT WORK ?]
noremap <leader>i i?<Esc>h 
noremap <leader>a a?<Esc>h 

" Modif selon type de fichier
filetype plugin indent on       "Indentation selon extension de fichier (nécessaire pour vundle)
syntax on                       "affichage des couleurs
au BufNewFile,BufRead *.pde setf arduino
au BufNewFile,BufRead *.mkd setf mkd
au BufNewFile,BufRead *.asm setf asm
au BufNewFile,BufRead *.adb setf ada*/
au BufNewFile,BufRead *.ads setf ada*/
au BufNewFile,BufRead *.py  setf python 
au BufNewFile,BufRead *.tex set encoding=utf-8
au BufNewFile,BufRead *.rb set shiftwidth=2
au BufNewFile,BufRead *.scala setf scala
au BufNewFile,BufRead {M,m}akefile set noexpandtab
au BufNewFile,BufRead *.lp setf prolog


" NEOCOMPLCACHE settings
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

" powerline setup
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set laststatus=2

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
        "highlight characters past column 120
        autocmd FileType python highlight Excess guibg=Green ctermbg=Blue
        autocmd FileType python match Excess /\%81v.*/
        autocmd FileType python set nowrap
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
"let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Delete ~/.vim/.netrwhist file after generation
au VimLeave * if filereadable("~/.vim/.netrwhist") | call delete("~/.vim/.netrwhist") | endif 

