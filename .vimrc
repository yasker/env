set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'alfredodeza/pytest.vim'

call vundle#end()
filetype plugin indent on

filetype on
filetype plugin on
filetype indent on
set autoread
set clipboard=unnamed
set background=dark
syntax on
"if has("gui_running")
"	colorscheme koehler
"else
"	colorscheme evening
"endif
" set fileencoding=gb18030
set fileencodings=ucs-bom,utf-8,gb18030,big5
set fileformats=unix,dos,mac
set wildmenu
set wildmode=longest:full
set mouse=a
set lazyredraw
set number
set cmdheight=1
" set backspace=indent
" set ignorecase smartcase
" set whichwrap+=<,>
set showmatch
set mat=5
set hlsearch " do not highlight searched for phrases
set incsearch " BUT do highlight as you type you search phrase
set report=0
set scrolloff=3
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff},\ %{&fenc}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff},\ %{&fenc}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set visualbell
" set cscopetag
set completeopt=menu,longest,preview
set foldenable
set foldmethod=indent
set foldlevel=100
set foldopen-=search
set foldopen-=undo

" let g:explVertical=1
" let g:explWinSize=35
" let g:winManagerWidth=35
" let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
" let g:miniBufExplTabWrap = 1
let g:LargeFile = 50
let perl_extended_vars=1
let html_use_css = 1
let html_no_pre = 1
let html_use_encoding = "utf-8"
let use_xhtml = 1

autocmd BufEnter * :syntax sync fromstart
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL '\s\+$'
set shortmess=at
"
"map <C-B> <ESC>:e %:p:h<RETURN>
"map <C-F4> <ESC>:bd<RETURN>
map <C-Left> <ESC>:bp!<RETURN>
map <C-Right> <ESC>:bn!<RETURN>

nmap <C-Down> :<C-u>move .+1<CR>
nmap <C-Up> :<C-u>move .-2<CR>

imap <C-Down> <C-o>:<C-u>move .+1<CR>
imap <C-Up> <C-o>:<C-u>move .-2<CR>

vmap <C-Down> :move '>+1<CR>gv
vmap <C-Up> :move '<-2<CR>gv

" for wildmenu
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" for taglist
let Tlist_Ctags_Cmd = "ctags" " Location of ctags
let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Show_Menu = 1
let Tlist_Display_Prototype = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Enable_Fold_Column = 0
"
" for c-fold
"autocmd BufNewFile,BufRead *.c,*.cpp,*.java :CFOLD
" autocmd BufNewFile,BufRead *.c,*.cpp,*.java zM

" for MySQL
autocmd BufNewFile,BufRead *.sql :set ft=mysql

" for icomplete
" let g:cppcomplete_placeholders = 1
" let g:cppcomplete_tagfile = "tags.icomplete"

" for spell
:command! -nargs=0 BeginSpell :set spell spelllang=en_us	" turn vim7 spell check on
:command! -nargs=0 EndSpell :set nospell			" turn vim7 spell check off

" for c/h switch
let g:alternateExtensions_h = "c,cpp"
let g:alternateExtensions_cpp = "h"
let g:alternateExtensions_c = "h"
map <F3> <ESC>:A<CR>

" Sync to current dir
:command! -nargs=0 SyncDir :lcd %:p:h

" for gtags
" map <C-G> :GtagsCursor<CR>

ia xdate <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>

set nohlsearch " do not highlight searched for phrases

nmap <Leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <Leader><Leader>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader><Leader>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Leader><Leader>d :scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <Leader><Leader><Leader>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader><Leader>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader><Leader>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader><Leader>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader><Leader>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader><Leader><Leader>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <Leader><Leader><Leader>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <Leader><Leader><Leader>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-]> :ptag <C-R>=expand("<cword>")<CR><CR>

nmap <C-[>l :set shiftwidth=8<CR>:set noexpandtab<CR>
nmap <C-[>g :set shiftwidth=4<CR>:set expandtab<CR>

if has("cscope")
"	add any database in current directory
	if filereadable("cscope.out")
	    cs add cscope.out
	"	else add database pointed to by environment
	"elseif $CSCOPE_DB != ""
	    "cs add $CSCOPE_DB
	endif
endif


imap <C-B> <Left>
imap <C-F> <Right>

let g:winManagerWindowLayout = 'TagList,FileExplorer|BufExplorer'
let g:winManagerWidth = 40
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:persistentBehaviour = 0
map <C-w><C-f> <ESC>:FirstExplorerWindow<cr>
map <C-w><C-b> <ESC>:BottomExplorerWindow<cr>

"set makeprg=makekvm.sh
set textwidth=80
"set viminfo='10,\"100,:20,%,n~/.viminfo
"au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

let g:tagbar_left=1
nmap <C-C> <ESC>:TagbarToggle<CR>
nmap <C-E> <ESC>:NERDTreeToggle<CR>

au FileType go nmap <Leader>g <Plug>(go-def)
au FileType go nmap <Leader><Leader>g <Plug>(go-def-split)
au FileType go nmap <Leader><Leader><Leader>g <Plug>(go-def-vertical)
au FileType go nmap <Leader>i <Plug>(go-implements)
au FileType go nmap <Leader>c <Plug>(go-callers)
au FileType go nmap <Leader>e <Plug>(go-callees)
au FileType go nmap <Leader>t <Plug>(go-callgraph)
"au FileType go nmap <Leader>s <Plug>(go-referrers)
au FileType go nmap <Leader>d <Plug>(go-describe)

set backspace=indent,eol,start

command Pytest Pytest file

if has('mouse_sgr')
	set ttymouse=sgr
endif

au FileType go nmap <Leader>s :Ag! <cword><CR><CR>

nmap <F1> <ESC>
lmap <F1> <ESC>


" set cindent
" set autoindent
set smartindent
set tabstop=8
"set softtabstop=4
set softtabstop=8
set shiftwidth=8
"set shiftwidth=4
"set noexpandtab
set expandtab
set smarttab
set cino=:0,g0,t0
