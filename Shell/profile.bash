# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# ,d88~~\             d8
# 8888     e88~~8e  _d88__       888  888 888-~88e
# `Y88b   d888  88b  888         888  888 888  888b
#  `Y88b, 8888__888  888         888  888 888  8888
#    8888 Y888    ,  888         888  888 888  888P
# \__88P'  "88___/   "88_/       "88_-888 888-_88"
#                                         888
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
force_color_prompt=yes
color_prompt=

#  ,d88~~\             d8     d8   ,e,                /
#  8888     e88~~8e  _d88__ _d88__  "  888-~88e e88~88e  d88~\
#  `Y88b   d888  88b  888    888   888 888  888 888 888 C888
#   `Y88b, 8888__888  888    888   888 888  888 "88_88"  Y88b
#     8888 Y888    ,  888    888   888 888  888  /        888D
#  \__88P'  "88___/   "88_/  "88_/ 888 888  888 Cb      \_88P
#                                                Y8""8D

### don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

### append to the history file, don't overwrite it
shopt -s histappend

### for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

### check the window size after each command and, if necessary,
### update the values of LINES and COLUMNS.
shopt -s checkwinsize

### If set, the pattern "**" used in a pathname expansion context will
### match all files and zero or more directories and subdirectories.
# shopt -s globstar

### make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

case $OSTYPE in
    linux*)
        export EDITOR=$(which vim)
        ;;
    darwin*)
        export EDITOR=$(which code || which mvim || which vim)
        ;;
esac

#  888~-_                                             d8
#  888   \  888-~\  e88~-_  888-~88e-~88e 888-~88e  _d88__
#  888    | 888    d888   i 888  888  888 888  888b  888
#  888   /  888    8888   | 888  888  888 888  8888  888
#  888_-~   888    Y888   ' 888  888  888 888  888P  888
#  888      888     "88_-~  888  888  888 888-_88"   "88_/
#                                         888
#
# note: macOS 上 Terminal / iTerm2 TERM="xterm-256color"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	    color_prompt=yes
    fi
fi

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

__prompt_command() {
    local EXIT="$?"
    PS1=""

    local RCol='\[\e[0m\]'

    local BBla='\[\e[1;30m\]'
    local BRed='\[\e[1;31m\]'
    local Red='\[\e[0;31m\]'
    local BGre='\[\e[1;32m\]'
    local Yel='\[\e[0;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    if [ $EXIT != 0 ]; then
        PS1+="${Red}\u${Rcol}"
    else
        PS1+="${BBla}\u${Rcol}"
    fi

    PS1+="${BBla}@\h ${Yel}\w${Pur}$(parse_git_branch) ${RCol}\n${BRed}\$${RCol} "
}

if [ "$color_prompt" = yes ]; then
    export PS1='\[\e[01;30m\]\u@\h \[\e[0;33m\]\w\[\e[35m\]$(parse_git_branch) \[\e[0m\]\n\[\e[1;31m\]\$\[\e[0m\] '
    export PS2='\[\e[0;31m\]>\[\e[0m\] '

    PROMPT_COMMAND=__prompt_command
else
    export PS1='\u@\h \w$(parse_git_branch) \n\$ '
    export PS2='> '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    # macOS Terminal / iTerm2 都是 xterm
    xterm*|rxvt*)
        PS1="\[\e]0;\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# 指令預設上色
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

#       e      888 ,e,
#      d8b     888  "    /~~~8e   d88~\
#     /Y88b    888 888       88b C888
#    /  Y88b   888 888  e88~-888  Y88b
#   /____Y88b  888 888 C888  888   888D
#  /      Y88b 888 888  "88_-888 \_88P

## ls
alias ll='ls -alF'
alias l='ls -CF'
## cd
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
## git
alias gl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias add="git add"
alias commit="git commit"
alias push="git push"
alias pull="get pull"

## grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
## docker
alias docker-up="docker-compose up -d"
alias docker-down="docker-compose down"
## bc - 計算機預設包含 math lib
alias bc="bc -l"
## openssl - 生成 SHA1 digest
alias sha1="openssl sha1"
## mkdir - 預設自動生成相依的目錄結構
alias mkdir="mkdir -pv"
## mount - 讓 Mount 指令易讀
alias mount="mount | column -t"
## history
alias h="history"
## jobs
alias j="jobs -l"
## path
alias path='echo -e ${PATH//:/\\n}'
## date
alias nowtime='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
## ping
alias ping='ping -c 5' # ping N 次後停止
## curl
alias header='curl -I'
alias headerc='curl -I --compress' # 確認是否支援 gzip / mod_deflate
## aws
alias s3='aws s3'

## 依照 OS 切換
case $OSTYPE in
    # Linux
    linux*)
        alias ls='ls --color=auto' # Colorized ls
        alias diff="colordiff"
        alias now='date +"%Y-%m-%d %T (%s.%3N)"'
        alias ports='netstat -tulanp' # Show open ports
        alias rm='rm -I --preserve-root' # 刪除多檔案前提示
        alias mv='mv -i'
        alias wget='wget -c' # 接續下載
        ;;
    # macOS
    darwin*)
        alias ls="ls -G" # Colorized ls
        alias now='date +"%Y-%m-%d %T (%s)"'
        alias ports='lsof -i -n -P | grep TCP' # Show open ports
        alias chrome='open -a "Google Chrome"'
        ;;
esac

#   e88~~\  ,e,   d8         888   |           888
#  d888      "  _d88__       888___|  e88~~8e  888 888-~88e   e88~~8e  888-~\
#  8888 __  888  888         888   | d888  88b 888 888  888b d888  88b 888
#  8888   | 888  888         888   | 8888__888 888 888  8888 8888__888 888
#  Y888   | 888  888         888   | Y888    , 888 888  888P Y888    , 888
#   "88__/  888  "88_/       888   |  "88___/  888 888-_88"   "88___/  888
#                                                  888
if [ -f $DIR/git-completion.bash ]; then
    . $DIR/git-completion.bash
fi


#  ~~~888~~~                                  888~-_
#     888     e88~~8e    /~~~8e  888-~\       888   \   e88~-_  Y88b    e    / 888-~88e
#     888    d888  88b       88b 888          888    | d888   i  Y88b  d8b  /  888  888
#     888    8888__888  e88~-888 888          888    | 8888   |   Y888/Y88b/   888  888
#     888    Y888    , C888  888 888          888   /  Y888   '    Y8/  Y8/    888  888
#     888     "88___/   "88_-888 888          888_-~    "88_-~      Y    Y     888  888
unset DIR color_prompt force_color_prompt
