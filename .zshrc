# -- {{{ my settings
#

if [[ -d /opt/android-sdk/ ]]; then
    PATH="$PATH:/opt/android-sdk"
fi

## var export
# for tmux: export 256color
[ -n "$TMUX" ] && export TERM=screen-256color

export EDITOR="vim"

## add highlighting for zsh; from AUR
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## add cdargs config
source $HOME/.zsh.d/cdargs.conf.zsh

## Options
# zsh允许你仅仅敲入你要进入的文件夹的路径,而不用输入cd
#setopt autocd
# ask question when may be type error
setopt CORRECT
# add new features for zsh globs
setopt extendedglob

## start from EMACS
if [ -n "$INSIDE_EMACS" ]; then
  chpwd() { print -P "\033AnSiTc %d" }
  print -P "\033AnSiTu %n"
  print -P "\033AnSiTc %d"
fi

## alias setting
alias pd='pushd'
alias pd2='pushd +2'
alias pd3='pushd +3'
alias pd4='pushd +4'
alias dirsv='dirs -v'
alias top='htop'
alias vi='vim'
alias df='df -h'
#alias emacs='LC_CTYPE=zh_CN.UTF-8 emacs'
alias emacs='emacs --no-desktop -nw'
alias rename='perl-rename'
alias dstat='dstat -cdlmnpsy'
#alias man='pinfo -m'

function lt() { ls -ltrsa "$@" | tail; }
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }
function fname() { find . -iname "*$@*"; }

# -- }}}


# -- {{{ settings from internet 
#

#color{{{
autoload colors 
colors

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval $color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
FINISH="%{$terminfo[sgr0]%}"
#}}}

#命令提示符 {{{
#RPROMPT=$(echo "$RED%D %T$FINISH")
PROMPT=$(echo "  $BLUE%/ 
${RED}${EXITCODE} $CYAN%n $_YELLOW>>>$FINISH ")
#}}}
    
#标题栏、任务栏样式{{{
case $TERM in (*rxvt*|*xterm*|(dt|k|E)term)
   #precmd () { print -Pn "\e]0;%n@%M//%/\a" }
   #preexec () { print -Pn "\e]0;%n@%M//%/\ $1\a" }
   precmd () { print -Pn "\e]0;%/\a" }
   preexec () { print -Pn "\e]0;%/\ $1\a" }
   ;;
esac
#}}}

#关于历史纪录的配置 {{{
#历史纪录条目数量
export HISTSIZE=10000
#注销后保存的历史纪录条目数量
export SAVEHIST=10000
#历史纪录文件
#export HISTFILE=~/.zhistory
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
#为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS

#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE      
#}}}

#每个目录使用独立的历史纪录{{{
cd() {
    builtin cd "$@"                             # do actual cd
    fc -W                                       # write current history  file
    local HISTDIR="$HOME/.zsh_history$PWD"      # use nested folders for history
        if  [ ! -d "$HISTDIR" ] ; then          # create folder if needed
            mkdir -p "$HISTDIR"
        fi
        export HISTFILE="$HISTDIR/zhistory"     # set new history file
    touch $HISTFILE
    local ohistsize=$HISTSIZE
        HISTSIZE=0                              # Discard previous dir's history
        HISTSIZE=$ohistsize                     # Prepare for new dir's history
    fc -R                                       #read from current histfile
}
mkdir -p $HOME/.zsh_history$PWD
export HISTFILE="$HOME/.zsh_history$PWD/zhistory"

function allhistory { cat $(find $HOME/.zsh_history -name zhistory) }
function convhistory {
            sort $1 | uniq |
            sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
            awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T",$1) "|"; print }'  
}
#使用 histall 命令查看全部历史纪录
function histall { convhistory =(allhistory) |
            sed '/^.\{20\} *cd/i\\' }
#使用 hist 查看当前目录历史纪录
function hist { convhistory $HISTFILE }

#全部历史纪录 top44
function top44 { allhistory | awk -F':[ 0-9]*:[0-9]*;' '{ $1="" ; print }' | sed 's/ /\n/g' | sed '/^$/d' | sort | uniq -c | sort -nr | head -n 44 }

#}}}

#杂项 {{{
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      
      
#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
#setopt AUTO_CD
      
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
      
#禁用 core dumps
limit coredumpsize 0

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}

#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

autoload -U compinit
compinit

#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

#彩色补全菜单 
eval $(dircolors -b) 
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
#错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全      
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

# cd ~ 补全顺序
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
#}}}

##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
#}}}

##空行(光标在行首)补全 "cd " {{{
user-complete(){
    case $BUFFER in
        "" )                       # 空行填入 "cd "
            BUFFER="cd "
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd --" )                  # "cd --" 替换为 "cd +"
            BUFFER="cd +"
            zle end-of-line
            zle expand-or-complete
            ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
            BUFFER="cd -"
            zle end-of-line
            zle expand-or-complete
            ;;
        * )
            zle expand-or-complete
            ;;
    esac
}
zle -N user-complete
bindkey "\t" user-complete
#}}}

##在命令前插入 sudo {{{
#定义功能 
#sudo-command-line() {
#    [[ -z $BUFFER ]] && zle up-history
#    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
#    zle end-of-line                 #光标移动到行末
#}
#zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
#bindkey "\e\e" sudo-command-line
#}}}
  
#命令别名 {{{
#alias -g cp='cp -i'
#alias -g mv='mv -i'
#alias -g rm='rm -i'
alias -g ls='ls -F --color=auto'
alias -g l='ls -dF --color=auto'
alias -g ll='ls -l -h'
alias -g grep='grep --color=auto'
alias -g ee='emacsclient -t'

#[Esc][h] man 当前命令时，显示简短说明 
#alias run-help >&/dev/null && unalias run-help
#autoload run-help

#历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
#}}}


#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
# hash -d WWW="/home/lighttpd/html"
# hash -d ARCH="/mnt/arch"
# hash -d PKG="/var/cache/pacman/pkg"
# hash -d E="/etc/env.d"
# hash -d C="/etc/conf.d"
# hash -d I="/etc/rc.d"
# hash -d X="/etc/X11"
# hash -d BK="/home/r00t/config_bak"
hash -d d="$HOME/Dropbox"
hash -d de="$HOME/Dropbox/emacs"
hash -d dl="$HOME/Dropbox/learn-web"
#}}}


##for Emacs {{{
#在 Emacs终端 中使用 Zsh 的一些设置 不推荐在 Emacs 中使用它
if [[ "$TERM" == "dumb" ]]; then
setopt No_zle
PROMPT='%n@%M %/
>>'
alias ls='ls -F'
fi 	
#}}}

#{{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.128.1{38,} www.g.cn \
       192.168.{1,0}.1{{7..9},}

#补全 ssh scp sftp 等
#my_accounts=(
#{r00t,root}@{192.168.1.1,192.168.0.1}
#kardinal@linuxtoy.org
#123@211.148.131.7
#)
#zstyle ':completion:*:my-accounts' users-hosts $my_accounts
#}}}

#{{{ F1 计算器
arith-eval-echo() {
  LBUFFER="${LBUFFER}echo \$(( "
  RBUFFER=" ))$RBUFFER"
}
zle -N arith-eval-echo
bindkey "^[[11~" arith-eval-echo

#{{{ F2 call
arith-eval-call() {
  LBUFFER="${LBUFFER}\$("
  RBUFFER=")$RBUFFER"
}
zle -N arith-eval-call
bindkey "^[[12~" arith-eval-call
#
#}}}

####{{{
function timeconv { date -d @$1 +"%Y-%m-%d %T" }

# }}}


## END OF FILE #################################################################
# vim:filetype=zsh foldmethod=marker autoindent expandtab shiftwidth=4 


do-cd-emacs() {
       LBUFFER="cd $(cat ~/.emacs.d/current-directory)"
       zle accept-line
}
zle -N do-cd-emacs
bindkey '\e[21~' do-cd-emacs #F10
