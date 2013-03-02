""" --- Base setting --- {{{

"" Normal stuff
set number        " line number
set showmode      " show mode in status line
set ruler         " show some info at status line
set nocompatible  " no vi with vim

"" Color
syntax on
colorscheme desertEx
set t_Co=256

"" Searching
set incsearch     " increment search
set hlsearch      " highlight search
set ignorecase    " case-insensitive search
set smartcase     " uppercase causes case-sensitive search

"" Tab
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab

"" Completion
set wildmenu                               " use tab show menu
" ignore it when select menu
set wildignore=*.o,*.jpg,*.png,*.gif,*.pdf
" list all matches and complete first match
set wildmode=list:full

"" Indent
set autoindent
set smartindent

"" Backups
set nobackup
set noswapfile

"" Encoding
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

"" File Type
filetype on
filetype plugin indent on

"" Mouse
set mouse=a " for select something,but it will move cursor

"" Key binding
" yank to the end of line
nnoremap Y y$
" clean hlsearch
nnoremap <F3> :nohlsearch<CR> 
" emacs Key binding
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <Home>
imap <C-e> <End>

""" --- End of Base setting --- }}}

""" --- Plugin --- {{{
"" Taglist
nnoremap <F2> :TlistOpen<CR> 

"" Clang complete
let g:clang_user_options='|| exit 0' 
let g:clang_use_library=1
set completeopt=longest,menu

"" Nerd Tree
nnoremap <F1> :NERDTreeToggle<CR> 

""" --- End of Plugin --- }}}

""" --- Test --- {{{

"" other indent
if has("autocmd")
    filetype plugin indent on "根据文件进行缩进
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \ exe "normal! g`\"" |
                    \ endif
    augroup END
else
    "智能缩进，相应的有cindent，官方说autoindent可以支持各种文件的缩进，但是效果会比只支持C/C++的cindent效果会差一点，但笔者并没有看出来
    set autoindent " always set autoindenting on 
endif " has("autocmd")

""" --- End of Test --- }}}
