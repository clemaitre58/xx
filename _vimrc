" -----------------------------------------------------------------------------
" Vim Settings
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" Constants

let s:isnix = has('unix')
let s:iswin = has('win16') || has('win32') || has('win64') || has('win32unix') || has('win95')
let s:ismac = has('mac')


" -----------------------------------------------------------------------------
" General

" don't be compatible with vi
set nocompatible

" set mapleader from backslash to comma
let mapleader=","

" disable <C-A>, interferes with tmux prefix
noremap <C-A> <nop>
inoremap <C-A> <nop>


" use utf-8 character encoding
set encoding=utf-8

" flush file to disk after writing for protection against data loss
set nofsync


" -----------------------------------------------------------------------------
" Plugins

if filereadable(expand('~/.vim/plugs.vim'))
  source ~/.vim/plugs.vim
endif


" " -----------------------------------------------------------------------------
" " Functions

" if filereadable(expand('~/.vim/functions.vim'))
"   source ~/.vim/functions.vim
" endif


" -----------------------------------------------------------------------------
" Basics

" descriptive window title
set title
if has('title') && (has('gui_running') || &title)
  set titlestring=
  set titlestring+=%f\                                              " File name
  set titlestring+=%h%m%r%w                                         " Flags
  set titlestring+=\ \|\ %{v:progname}                              " Program name
  set titlestring+=\ \|\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')} " Working directory
endif

" store backups in the same directory
set backupdir=~/.vim/.backups

" store swap files in the same directory
set directory=~/.vim/.swaps

" store undo files in the same directory
set undodir=~/.vim/.undo

" don't clear screen when vim closes
set t_ti= t_te=

" timeout settings
set timeout
set nottimeout
set timeoutlen=1000
set ttimeoutlen=50

" greatly restrict local .vimrc and .exrc files
set secure

" make directories if necessary
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif


" -----------------------------------------------------------------------------
" Display

" vim {{{

" dark background
set background=dark

if $TERM == "rxvt-unicode-256color" || $TERM == "xterm-256color" || $TERM == "screen-256color" || $TERM == "screen-it-256color" || $COLORTERM == "gnome-terminal"
  " jellyx
  set t_Co=256
  colorscheme jellyx
elseif $TERM == "linux" || $TERM == "screen"
  " miro8
  colorscheme miro8
  highlight clear Pmenu
  highlight Pmenu ctermfg=7 ctermbg=0
endif

" }}}


" screen {{{

" turn off syntax coloring of long lines
set synmaxcol=1024

" refresh screen
nnoremap <silent> <leader>u :syntax sync fromstart<CR>:redraw!<CR>

" }}}


" -----------------------------------------------------------------------------
" Editing

" never write or update the contents of any buffer unless we say so
set noautowrite
set noautowriteall
set noautoread

" read unix, dos and mac file formats
set fileformats=unix,dos,mac

" always keep cursor in the same column if possible
set nostartofline

" use a dialog when an operation has to be confirmed
set confirm

" DO show us the command we're typing
set showcmd

" always report the number of lines changed
set report=0

" don't highlight the screen line or column
set nocursorline nocursorcolumn

" save undo history to an undo file
set undofile

" allow N number of changes to be undone
set undolevels=500

" store N previous vim commands and search patterns
set history=500

" always show statusline
set laststatus=2

" don't highlight matching parens
set noshowmatch

" write swap file every N characters
set updatecount=20

" do not redraw screen when executing macros
set lazyredraw

" generous backspacing
set backspace=2

" number of screen lines around cursor
set scrolloff=8
set sidescrolloff=16
set sidescroll=1

" break lines at sensible place
set linebreak

" wrap on these chars
set whichwrap+=<,>,[,]

" indicate wrapped characters
set showbreak=⁍

" copy indent from current line when starting a new line
set autoindent

" sets the width of a <Tab> character
set tabstop=2

" when enabled, causes spaces to be used instead of <Tab> characters
set expandtab

" when enabled, sets the amount of whitespace to be inserted/removed on <Tab> / <BS>
" if softtabstop < tabstop, and expandtab is disabled (with noexpandtab), vim will start <Tab>s with whitespace
" this initial whitespace will be dynamically converted to / from <Tab> characters as the indent level of 'tabstop' is reached / unreached
set softtabstop=2

" sets the amount of space to insert / remove while using indentation commands in normal mode (>, <)
set shiftwidth=2

" round indent to multiple of shiftwidth
set shiftround

" visually break lines
set wrap

" show the line number in front of each line
set number

" minimum number of columns to use for the line number
set numberwidth=1

" insert N pixel lines between characters
set linespace=1

" <Tab> in front of a line inserts blanks according to shiftwidth
set smarttab

" don't wrap searches around the end of the file
set nowrapscan

" search options: incremental search, highlight search
set incsearch
set hlsearch

" ignore case in search patterns
set ignorecase

" override the ignorecase option if the search pattern contains upper case characters
set smartcase

" adjust the case of the match depending on the typed text
set infercase

" automatic formatting options
set formatoptions=
set formatoptions+=r " Automatically insert the current comment leader after <Enter> in insert mode
set formatoptions+=o " Automatically insert the current comment leader after 'o' or 'O' in normal mode
set formatoptions+=q " Allow formatting of comments with gq
set formatoptions+=n " Recognize numbered lists when formatting text
set formatoptions+=2 " Use the indent of the second line of a paragraph for the rest of the paragraph instead of the first
set formatoptions+=l " Don't break long lines in insert mode
set formatoptions+=1 " Don't break a line after a one-letter word
set formatoptions+=j " Remove comment leader when joining two comments


" -----------------------------------------------------------------------------
" Shortcuts

" Editing
" --- selecting {{{

" bind escape key
call arpeggio#load()
Arpeggio noremap jk <ESC>
Arpeggio inoremap jk <ESC>
Arpeggio cnoremap jk <C-C>

" visually select the text that was last edited/pasted
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" preserve selection when indenting
vnoremap > >gv
vnoremap < <gv
nnoremap > >>
nnoremap < <<

" }}}
" --- toggle showcmd {{{

nnoremap <silent> <leader>sc :set showcmd!<CR>

" }}}

" --- don't move back the cursor one position when exiting insert mode {{{

augroup cursorpos
  autocmd!
  autocmd InsertEnter * let CursorColumnI = col('.')
  autocmd CursorMovedI * let CursorColumnI = col('.')
  autocmd InsertLeave * if col('.') != CursorColumnI | call cursor(0, col('.')+1) | endif
augroup END

" }}}

" --- search and replace {{{

" turn off any existing search
if has('autocmd')
  augroup searchhighlight
    autocmd!
    autocmd VimEnter * nohls
  augroup END
endif

" remove search highlights
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" use vimgrep without autocommands being invoked
nnoremap <leader>nv :noautocmd vim /

" highlight all occurrences of current word
nnoremap <silent> <leader><leader>h :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" }}}

" --- pasting {{{

" yank to end of line
noremap Y y$

" copy to clipboard
vnoremap <leader>y "+yy
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$

" paste from clipboard
noremap <leader>p "+p
noremap <leader>P "+P

" toggle paste mode
set pastetoggle=<F2>

" }}}

" --- formatting {{{

" format visual selection with spacebar
vnoremap <space> :!fmt<CR>

" }}}
" --- proofreading {{{

" find lines longer than 78 characters
nnoremap <leader><leader>l /^.\{-}\zs.\%>79v<CR>

" find two spaces after a period
nnoremap <leader><leader>. /\.\s\s\+\w/s+1<CR>

" find things like 'why ?' and 'now !'
nnoremap <leader><leader>! /\w\s\+[\?\!\;\.\,]/s+1<CR>

" find multiple newlines together
nnoremap <leader><leader>cr /\n\{3,\}/s+1<CR>

" }}}
" --- writing {{{

" quick write
nnoremap <silent> <leader>w :w<CR>

" sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" expand %% to the path of the current buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" change to directory of file
nnoremap <silent> <leader>. :cd%:h<CR>

" fix windoze ^M
" alternative to `dos2unix file`
noremap <leader>rmm :%s///g<CR>

" prevent accidental writes to buffers that shouldn't be edited
augroup readonly
  autocmd!
  autocmd BufRead *.orig set readonly
  autocmd BufRead *.pacnew set readonly
augroup END

" }}}
" --- redoing {{{

" maintain location in document while redoing
nnoremap . .`[

" qq to record, Q to replay
nnoremap Q @q

" }}}
" --- words {{{

" Lines
" --- toggle {{{

" toggle line wrap
noremap <silent> <F3> :set nowrap!<CR>
inoremap <silent> <F3> <C-O>:set nowrap!<CR>
vnoremap <silent> <F3> <ESC>:set nowrap!<CR>gv

" toggle line numbers
nnoremap <silent> <F4> :NumbersToggle<CR>
inoremap <silent> <F4> <C-O>:NumbersToggle<CR>
vnoremap <silent> <F4> <ESC>:NumbersToggle<CR>gv

" toggle line and column highlighting
noremap <silent> <F5> :set nocursorline! nocursorcolumn!<CR>
inoremap <silent> <F5> <C-O>:set nocursorline! nocursorcolumn!<CR>
vnoremap <silent> <F5> <ESC>:set nocursorline! nocursorcolumn!<CR>gv

" toggle spell checking
noremap <silent> <F7> :set spell! spelllang=en_us<CR>
inoremap <silent> <F7> <C-O>:set spell! spelllang=en_us<CR>
vnoremap <silent> <F7> <ESC>:set spell! spelllang=en_us<CR>gv

" convert all tabs into spaces and continue session with spaces
nnoremap <silent><expr> g<M-t> ':set expandtab<CR>:retab!<CR>:echo "Tabs have been converted to spaces"<CR>'

" convert all spaces into tabs and continue session with tabs
nnoremap <silent><expr> g<M-T> ':set noexpandtab<CR>:%retab!<CR>:echo "Spaces have been converted to tabs"<CR>'

" }}}
" --- split/join {{{

" keep the cursor in place while joining lines
nnoremap J mzJ`z

" split line
nnoremap <silent> S i<CR><ESC>^mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" }}}
" --- editing {{{

" delete char adjacent-right without moving cursor over one from the left
nnoremap <silent> gx @='lxh'<CR>

"  }}}
" --- movement {{{

" move between beginning and end of line
nnoremap H ^
vnoremap H ^
nnoremap L g_
vnoremap L g_

" move to middle of current line
nnoremap <expr> gM (strlen(getline("."))/2)."<Bar>"

" move to last change
nnoremap gI `.

" <PageUp> and <PageDown> do silly things in normal mode with folds
noremap <PageUp> <C-U>
noremap <PageDown> <C-D>

" scroll four lines at a time
nnoremap <C-E> 4<C-E>
nnoremap <C-Y> 4<C-Y>

" }}}

" Programming
" --- tabs {{{

" set tabstop, shiftwidth and softtabstop to same (specified) value
nnoremap <leader>ts :Stab<CR>

" echo tabstop, shiftwidth, softtabstop and expandtab values
nnoremap <leader>st :call SummarizeTabs()<CR>

"  }}}
" --- folds {{{

" toggle folds with g+spacebar
nnoremap <silent> g<space> :exe ":silent! normal za"<CR>

" focus just the current line with minimal number of folds open
nnoremap <silent> <leader><leader><space> :call FocusLine()<CR>

" make zO recursively open whatever fold we're in, even if it's partially open
nnoremap zO zczO

" set fold level
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>

"  }}}
" --- merging {{{

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" jump to next conflict marker
nnoremap <silent> <leader>jc /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

" }}}
" --- hex {{{

" toggle between hex and binary, after opening file with `vim -b`
noremap <silent> <F9> :call HexMe()<CR>
inoremap <silent> <F9> <C-O>:call HexMe()<CR>
vnoremap <silent> <F9> <ESC>:call HexMe()<CR>gv

" }}}
" --- unicode {{{

" toggle display unicode operators in code without changing the underlying file
noremap <silent> <leader><leader>cl :call ConcealToggle()<CR>

" }}}

" Navigation
" --- buffers {{{

" buffer navigation
nnoremap <silent> gd :bdelete<CR>
nnoremap <silent> gb :bnext<CR>
nnoremap <silent> gB :bprev<CR>
nnoremap <silent> <leader>1 :<C-U>buffer 1<CR>
nnoremap <silent> <leader>2 :<C-U>buffer 2<CR>
nnoremap <silent> <leader>3 :<C-U>buffer 3<CR>
nnoremap <silent> <leader>4 :<C-U>buffer 4<CR>
nnoremap <silent> <leader>5 :<C-U>buffer 5<CR>
nnoremap <silent> <leader>6 :<C-U>buffer 6<CR>
nnoremap <silent> <leader>7 :<C-U>buffer 7<CR>
nnoremap <silent> <leader>8 :<C-U>buffer 8<CR>
nnoremap <silent> <leader>9 :<C-U>buffer 9<CR>

" }}}
" --- windows {{{

" map alt-[h,j,k,l,=,_,|] to resizing a window split
" map alt-[s,v] to horizontal and vertical split respectively
" map alt-[N,P] to moving to next and previous window respectively
" map alt-[H,J,K,L] to repositioning a window split
nnoremap <silent> <M-h> :<C-U>ObviousResizeLeft<CR>
nnoremap <silent> <M-j> :<C-U>ObviousResizeDown<CR>
nnoremap <silent> <M-k> :<C-U>ObviousResizeUp<CR>
nnoremap <silent> <M-l> :<C-U>ObviousResizeRight<CR>
nnoremap <silent> <M-=> <C-W>=
nnoremap <silent> <M-_> <C-W>_
nnoremap <silent> <M-\|> <C-W>\|
nnoremap <silent> <M-s> :split<CR>
nnoremap <silent> <M-v> :vsplit<CR>
nnoremap <silent> <M-N> <C-W><C-W>
nnoremap <silent> <M-P> <C-W><S-W>
nnoremap <silent> <M-H> <C-W>H
nnoremap <silent> <M-J> <C-W>J
nnoremap <silent> <M-K> <C-W>K
nnoremap <silent> <M-L> <C-W>L

" create a split on the given side
nnoremap <leader>swh :leftabove vsp<CR>
nnoremap <leader>swl :rightbelow vsp<CR>
nnoremap <leader>swk :leftabove sp<CR>
nnoremap <leader>swj :rightbelow sp<CR>

" scroll specified file simultaneously in vsplit window
nnoremap <leader>sb :SplitScrollSpecified<space>

" scroll all windows simultaneously
nnoremap <silent> <S-F5> :windo set scrollbind!<CR>
inoremap <silent> <S-F5> <C-O>:windo set scrollbind!<CR>

" }}}
" --- tabs {{{

" new tab
nnoremap <silent> <M-Down> :tabnew<CR>

" close tab
nnoremap <silent> <M-d> :tabclose<CR>

" switch between tabs
nnoremap <silent> ( @='gT'<CR>
nnoremap <silent> ) @='gt'<CR>

" move tab adjacent
nnoremap <silent> g( :<C-U>:execute "tabmove -" . v:count1<CR>
nnoremap <silent> g) :<C-U>:execute "tabmove +" . v:count1<CR>

" move tab
noremap <leader>tm :tabmove<space>

" open specified file in new tab
noremap <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

" allows typing :tabv myfile.txt to view the specified file in a new read-only tab
cabbrev tabv tab sview +setlocal\ nomodifiable

" }}}


" -----------------------------------------------------------------------------
" Filetype Settings

if filereadable(expand('~/.vim/filetypes.vim'))
  source ~/.vim/filetypes.vim
endif


" -----------------------------------------------------------------------------
" Plugin Settings

if filereadable(expand('~/.vim/settings.vim'))
  source ~/.vim/settings.vim
endif

let g:ycm_path_to_python_interpreter = '/usr/local/Cellar/python/2.7.10_2/Frameworks/Python.framework/Versions/Current/bin/python'
