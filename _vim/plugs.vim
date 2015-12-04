silent! if plug#begin('~/.vim/plugged')

Plug 'kana/vim-arpeggio'
Plug 'guns/jellyx.vim'

Plug 'vim-scripts/indentpython.vim'
" Plug 'Valloric/YouCompleteMe'
Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'

Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'

" utilities / dependencies
Plug 'vim-scripts/ingo-library'
Plug 'xolox/vim-misc'
Plug 'junegunn/vim-pseudocl'
Plug 'Shougo/vimproc.vim'
Plug 'tpope/vim-scriptease'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-user'
call plug#end()
endif
