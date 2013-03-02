""" --- Base setting --- {{{

"" Normal stuff
set number        " line number
set showmode      " show mode in status line
set wildmenu      " use tab show menu
set ruler         " show some info at status line
set nocompatible  " no vi with vim
set nobackup      
syntax on
colorscheme desertEx

"" Searching
set incsearch           " increment search
set hlsearch            " highlight search
set ignorecase          " case-insensitive search
set smartcase           " uppercase causes case-sensitive search

"" Tab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smarttab " insert tab when 

"" Indent
set autoindent
set smartindent
filetype plugin indent on

"" Mouse
set mouse=a " for select something,but it will move cursor

"" Key binding
" Clean hlsearch
nnoremap <F2> :noh<CR> 

""" --- End of Base setting --- }}}

""" --- Plugin --- {{{

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
