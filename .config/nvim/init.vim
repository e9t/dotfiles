" Source vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'github/copilot.vim'
Plug 'junegunn/seoul256.vim'
Plug 'kien/ctrlp.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
