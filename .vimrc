set nu
set wildmenu "tab補全顯示菜單
set vb t_vb=
set showmode
set nocompatible
set ruler
set incsearch "在输入要搜索的文字时，vim会实时匹配
set backspace=indent,eol,start whichwrap+=<,>,[,] "允许退格键的使用
set nocompatible "不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题

" tab
set tabstop=4 "让一个tab等于4个空格
"set et
"set ts=4
"set sw=4
set smarttab
set is
"set smartindent

" ack instead of grep
set grepprg=ack 
set grepformat=%f:%l:%c:%m

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

au GUIEnter * simalt ~x

colorscheme desert
syntax on

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
"nmap wm :WMToggle<cr>
