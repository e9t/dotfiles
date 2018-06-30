"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original: Amir Salihefendic (http://amix.dk - amix@amix.dk)
"       Version 5.0 - 29/05/12 15:43:36
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Modifier: Lucy Park (http://lucypark.kr - 525600min@gmail.com)
"
" Sections:
"     1. General
"     2. VIM user interface
"     3. Colors and Fonts
"     4. Files and backups
"     5. Text, tab and indent related
"     6. Visual mode related
"     7. Moving around, tabs and buffers "    ->  Status line
"     8. Editing mappings
"     9. vimgrep searching and cope displaying
"     10. Spell checking
"     11. Misc
"     13. Helper functions
"     14. Customized
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2. VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Extra margin to the left
set foldcolumn=0

" Fold
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 3. Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
" colorscheme should come after pathogen
syntax enable
set t_Co=256
 let g:solarized_termcolors=256
set background=dark
colorscheme leo
set colorcolumn=80


" Set extra options when running in GUI mode
" Comes out weird for colorschemes though
" http://stackoverflow.com/q/4229658/1054939
"set guioptions-=T
"set guioptions-=e
"set guitablabel=%M\ %t

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
" set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 4. Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 5. Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab
set nosmartindent

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" 6. Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" [Search for selected text](http://vim.wikia.com/wiki/Search_for_visually_selected_text)
vnoremap // y/<C-R>"<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 7. Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
"
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" 7. Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 8. Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing whitespace on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  %s/\s\+$//ge
endfunc
func! ReplaceQuotes()
  %s/[“”]/"/ge
  %s/[‘’]/'/ge
endfunc
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.css :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()
autocmd BufWrite *.html :call DeleteTrailingWS()
autocmd BufWrite *.less :call DeleteTrailingWS()
autocmd BufWrite *.markdown :call DeleteTrailingWS()
autocmd BufWrite *.md :call DeleteTrailingWS()
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.tex :call DeleteTrailingWS()
autocmd BufWrite *.markdown :call ReplaceQuotes()
autocmd BufWrite *.md :call ReplaceQuotes()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 9. vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 10. Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 11. Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 13. Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 14. Customized (Overrrides current file settings)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function keys
" For lorem ipsum
let lorem="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam quis posuere risus, porta facilisis felis. Aliquam erat volutpat. Aenean elit elit, bibendum et leo sit amet, dapibus porttitor dui. Integer mollis hendrerit varius. Suspendisse ullamcorper justo magna, nec efficitur dolor blandit nec. Sed tincidunt lorem at enim placerat, in feugiat risus aliquet. Quisque ultrices nisi vel tortor auctor imperdiet. Nam non sem dignissim, pretium lectus non, tristique velit. Duis scelerisque augue non dui molestie interdum."
nmap <F4> i<C-R>=lorem<CR><Esc>
imap <F4> <C-R>=lorem<CR>

" [For timestamping](http://stackoverflow.com/a/58604/1054939)
nmap <leader>t i<C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR><Esc>
imap <leader>t <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>
nmap <leader>d i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
imap <leader>d <C-R>=strftime("%Y-%m-%d")<CR>

" Input docs/dm
imap <leader>m <C-R>="/docs/dm/"<CR>

" Toggle list
nnoremap <leader>l :set list!<CR>

" Remove trailing whitespaces
map <F8> :call DeleteTrailingWS() <CR>

" For compiling and running programs
map <F9> :!g++ % && ./a.out <CR>
map <leader>0 :!gcc % && ./a.out <CR>

" [Source .vimrc file in pwd](http://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/)
set exrc
set secure

" Sets line number
set number

" Set status line
set statusline=\ %F%m%r%h\ %w\                     "File, Modified? Readonly?
set statusline+=\ %y\                                   "FileType
set statusline+=\ [%{''.(&fenc!=''?&fenc:&enc).''}]     "Encoding
set statusline+=\ %=\ row:%l/%L\ (%02p%%)\              "Rownumber/total (%)

" Hide tabline
set showtabline=1

" Use templates
autocmd! BufNewFile * silent! 0r ~/.vim/skel/template.%:e

" Prompt 'yes'/'no'/'cancel' if closing with unsaved changes
set confirm

" For Vim-R-plugin
set nocompatible

" [For ctrlp symlink nav](http://vi.stackexchange.com/a/2727/8217)
let g:ctrlp_follow_symlinks=1

" [*.md as markdown files](http://stackoverflow.com/a/23279293/1054939)
autocmd BufNewFile,BufRead *.md set filetype=markdown

" Open doc file in Chrome
" http://vim.wikia.com/wiki/Preview_current_HTML_file
" http://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers
nnoremap <leader>b :!open -a "Google Chrome" http://localhost:4000/docs/%:p:r:s?/.*/_docs/??/<CR><CR>

" Open doc in Haroopad
nnoremap <leader>c :!open -a "Haroopad" %:p<CR>

" Open any file in Sublime
nnoremap <leader>s :!open -a "Sublime Text" %:p<CR>

" [Highlight tabs](http://stackoverflow.com/q/24232354/1054939)
" Unset by entering `set nolist`
set listchars=tab:>-
set list
highlight Whitespace ctermfg=DarkBlue
highlight ColorColumn ctermbg=DarkRed
autocmd bufenter * match Whitespace /\s/
map <leader>s :set list!<cr>

" [Nerdtree](https://github.com/scrooloose/nerdtree)
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close vim if only nerdtree is left
let NERDTreeShowHidden=1  " show hidden files

" [tagbar](https://github.com/majutsushi/tagbar)
map <C-b> :TagbarToggle<CR>

" [Syntastic](https://github.com/scrooloose/syntastic)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_html_checkers=['']
let g:syntastic_tex_chktex_args = '--nowarn=8 --nowarn=44'
" E221 - multiple spaces before operator
" E402 - module level import not at top of file
" E501 - line too long
let g:syntastic_python_flake8_post_args='--ignore=E221,E402,E501'
command! S execute ':SyntasticToggleMode'

" [junegunn/vim-easy-align: A Vim alignment plugin](https://github.com/junegunn/vim-easy-align)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" https://gist.github.com/staltz/6595113
syn keyword TodoKeywords TODO
highlight TodoKeywords cterm=bold term=bold ctermfg=Black ctermbg=Yellow

" https://www.reddit.com/r/vim/comments/320ej2/vimrc_syntax_highlighting_broken_with_long/
syntax sync fromstart
au BufEnter *.* :syntax sync fromstart

" [vim-markdown](https://github.com/plasticboy/vim-markdown)
let g:vim_markdown_math=1

" https://github.com/embear/vim-localvimrc
let g:localvimrc_persistent=2

" [ctags](https://stackoverflow.com/a/5019111/1054939)
set tags=tags;/
nnoremap <leader>. :CtrlPTag<cr>
