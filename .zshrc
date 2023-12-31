#色を使用できるようにする
export LANG=ja_JP.UTF-8

export ZSH=$HOME/.my-zsh
ZSH_THEME="robbyrussell"
source $ZSH/my-zsh.sh

# brew
if [ -e /opt/homebrew ]; then
  export PATH=$PATH:/opt/homebrew/bin
fi

# GPG
export GPG_TTY=$(tty)

# Anyenv
export PATH="$PATH:$HOME/.anyenv/bin"
eval "$(anyenv init -)"

autoload -Uz colors
colors

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

# cdの後にlsを実行
chpwd() {
    ls
}

preexec() {
    echo -e "\e[31m$(pwd) \e[32m➜  \e[m$1"
}

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

########
# 履歴系
########

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

# 入力したコマンドがすでにコマンド履歴に含まれる場合、
# 履歴から古いほうのコマンドを削除する
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space

# ヒストリーに重複を表示しない
setopt histignorealldups

# ヒストリーのストック量を制限
HISTFILE=~/.zsh_history
HISTSIZE=500
SAVEHIST=500



################
# エイリアス設定
################
if [ $(uname) = "Darwin" ]; then
    alias l='ls -FG'
    alias ls='ls -FG'
    alias gls='ls -FG'
elif [ $(uname) = "Linux" ]; then
    alias ls='ls -F --color=always '
fi

alias la='ls -a'
alias ll='ls -laFh'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

alias ...='cd ../..'
alias ....='cd ../../../'

alias vi='vim'
alias cc11='cc -std=c99'

seikei_proxy=proxy.cc.seikei.ac.jp:8080
switch_trigger=seikei
if [ "`networksetup -getcurrentlocation`" = "$switch_trigger" ]; then
   export http_proxy=$seikei_proxy
   export https_proxy=$seikei_proxy
   export ftp_proxy=$seikei_proxy
else
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
fi


function command_not_found_handler(){
    echo -e "\e[30m\e[46m   $1   \e[m is not command"
}


cat << "EOF"
    __  __     ____                                       __         ____            __              _
   / / / /__  / / /___     ____ ___  __  __   ____  _____/ /_       / __ \___       / /             | |____________
  / /_/ / _ \/ / / __ \   / __ `__ \/ / / /  /_  / / ___/ __ \     / / / / __ \    / /_____ _____   / /_  /_  /_  /
 / __  /  __/ / / /_/ /  / / / / / / /_/ /    / /_(__  ) / / /    / /_/ / /_/ /  / /_____//_____/  / / / /_/ /_/ /_
/_/ /_/\___/_/_/\____/  /_/ /_/ /_/\__, /    /___/____/_/ /_/     \____/\____(_)/ /   ______      /_/ /___/___/___/
                                  /____/                                        |_|  /_____/     /_/                
EOF
