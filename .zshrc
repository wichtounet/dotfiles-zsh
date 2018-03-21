
export REPORTTIME=10

# Make sure the correct editor is used
export EDITOR="/usr/bin/vim"

# Python virtual envs
if [[ -r /usr/bin/virtualenvwrapper_lazy.sh ]]; then
    source /usr/bin/virtualenvwrapper_lazy.sh
fi

# Custom installation to library path
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH::/home/wichtounet/install/lib"

# Add suport for MKL libraries
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/intel/mkl/lib/intel64"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/intel/lib/intel64"

# Add Intel 2015 tools to the path
export PATH="$PATH:/opt/intel/vtune_amplifier_xe_2015/bin64/"
export PATH="$PATH:/opt/intel/inspector_xe_2015/bin64/"
export PATH="$PATH:/opt/intel/composer_xe_2015/bin64/"
export PATH="$PATH:/opt/intel/advisor_xe_2015/bin64/"

# Add Intel 2016 tools to the path
export PATH="$PATH:/opt/intel/vtune_amplifier_xe_2016/bin64/"
export PATH="$PATH:/opt/intel/inspector_xe_2016/bin64/"
export PATH="$PATH:/opt/intel/composer_xe_2016/bin64/"
export PATH="$PATH:/opt/intel/advisor_xe_2016/bin64/"
export PATH="$PATH:/opt/intel/compilers_and_libraries/linux/pkg_bin/intel64/"

# Add Cuda tools to the path
export PATH="$PATH:/opt/cuda/bin/"

# Add ccache to the path
export PATH="/usr/lib64/ccache/bin:$PATH"

# Add cross compiler to path
export PATH="/home/wichtounet/opt/cross/bin/:$PATH"

# Add clang to the path
export PATH="/usr/lib64/llvm/4/bin/:$PATH"

# Configure distcc
export DISTCC_HOSTS='160.98.22.10:3632/8,cpp,lzo 160.98.22.11:3632/8,cpp,lzo 160.98.22.12:3632/8,cpp,lzo 160.98.22.13:3632/8,cpp,lzo 160.98.22.14:3632/8,cpp,lzo 160.98.22.15:3632/8,cpp,lzo 160.98.22.16:3632/8,cpp,lzo 160.98.22.17:3632/8,cpp,lzo 160.98.22.18:3632/8,cpp,lzo 160.98.22.19:3632/8,cpp,lzo'
export DISTCC_HOSTS_DLL='160.98.22.10:3632/2,cpp,lzo 160.98.22.11:3632/2,cpp,lzo 160.98.22.12:3632/2,cpp,lzo 160.98.22.13:3632/2,cpp,lzo 160.98.22.14:3632/2,cpp,lzo 160.98.22.15:3632/2,cpp,lzo 160.98.22.16:3632/2,cpp,lzo 160.98.22.17:3632/2,cpp,lzo 160.98.22.18:3632/2,cpp,lzo 160.98.22.19:3632/2,cpp,lzo localhost/2,cpp,lzo'
#export DISTCC_HOSTS='160.98.22.10:8080/8,cpp,lzo 160.98.22.11:8080/8,cpp,lzo 160.98.22.12:8080/8,cpp,lzo 160.98.22.14:8080/8,cpp,lzo 160.98.22.15:8080/8,cpp,lzo 160.98.22.16:8080/8,cpp,lzo 160.98.22.17:8080/8,cpp,lzo 160.98.22.18:8080/8,cpp,lzo 160.98.22.19:8080/8,cpp,lzo'
#export DISTCC_HOSTS_DLL='160.98.22.10:8080/2,cpp,lzo 160.98.22.11:8080/2,cpp,lzo 160.98.22.12:8080/2,cpp,lzo 160.98.22.14:8080/2,cpp,lzo 160.98.22.15:8080/2,cpp,lzo 160.98.22.16:8080/2,cpp,lzo 160.98.22.17:8080/2,cpp,lzo 160.98.22.18:8080/2,cpp,lzo 160.98.22.19:8080/2,cpp,lzo localhost/2,cpp,lzo'
export DISTCC_VERBOSE=0

alias xmake='LD=/usr/bin/g++-7.2.0 CXX=/usr/lib64/distcc/bin/g++-7.2.0 pump make -j80'
alias xmake_dll='DISTCC_HOSTS=$DISTCC_HOSTS_DLL LD=/usr/bin/g++-7.2.0 CXX=/usr/lib64/distcc/bin/g++-7.2.0 pump make -j22'
alias xmake_nolink='LD=true CXX=/usr/lib64/distcc/bin/g++-7.2.0 pump make -j80'

alias piss_on_grid='export LD=true; while true; do make clean && xmake_nolink all && true; sleep 5; done'

alias templight_make='CC=templight LD=templight++ CXX=templight++ make'

alias gdbrun='gdb -ex run --args '

#Configure CCache
export CCACHE_DIR="/data/ccache"
export CCACHE_SIZE="8G"

# Force pdflatex to print with lots of columns
export max_print_line=100000

# Include stuff thas is local to the computer
if [[ -r ~/.local.zshrc ]]; then
	source ~/.local.zshrc
fi

# Install k
source /home/wichtounet/k/k.sh

# Enable colors
autoload -U colors && colors

# Allow for functions in the prompt
setopt PROMPT_SUBST

# Configure completion for taskwarrior
fpath=($fpath /usr/local/share/doc/task/scripts/zsh)

# Enable completion
autoload -Uz compinit && compinit

# Enable correction
setopt correctall

# Enable advanced prompt
autoload -U promptinit && promptinit

#Cache for completions
zstyle ':completion::complete:*' use-cache 1

# Completion style improvements
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Group by tag names
zstyle ':completion:*' group-name ''

# Define the output of the time command
TIMEFMT=$'real\t%E\nuser\t%U\nsys\t%S'

# Basic history configuration
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt inc_append_history

# Improve duplicate configuration
setopt hist_ignore_all_dups

# Enable oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

export DEFAULT_USER="wichtounet"
export ZSH_THEME="agnoster"
plugins=(autojump git git-flow taskwarrior gpg-agent ssh-agent zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

#Always display the line where grep found something
alias grep='grep -n'

# Aliases for k
alias ll='k'
alias lla='k -a'

#Utility aliases for git
alias gc='git commit'
alias gca='git commit -a'
alias gcadd='git add -A'
alias gsu='git submodule update'
alias gpl='git pull'
alias amend='git commit --amend'

# Misc aliases
alias mkdir='mkdir -pv'
alias mounts='mount |column -t'
alias ports='netstat -tulanp'
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias wget='wget -c'
alias df='df -H'
alias du='du -d1 -h'
alias sorry='sudo $(fc -l -n -1)'
alias asshole='echo Alright. You do not have to be rude, you know. && sleep 0.8 && sudo $(fc -l -n -1)'

alias gcc_make='make CXX=g++-4.9.4 LD=g++-4.9.4'
alias clang_make='make CXX=clang++ LD=clang++'
alias icc_make='make CXX=icpc LD=icpc'
alias pump_make='pump make CXX="distcc /usr/bin/clang++"'

alias pump_make='pump make -j16 CXX="distcc /usr/bin/clang++" CC="distcc /usr/bin/clang"'

# Alias to edit a Latex course or presentation
alias course='zathura build/master.pdf & ; urxvt -e zsh -i -c "workon latex && pytex watch" & ; vim master.tex.rst'

make_less() {
    make $@ 2>&1 | less
}

# Copy with pv
function pvcp(){
  SOURCE=$1

  if [ -d $2 ]
  then
    DESTINATION=$2/`basename $SOURCE`
  else
    DESTINATION=$2
  fi

  pv ${SOURCE} | > ${DESTINATION}
}

# mdless function
function mdless(){
  pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

function pygmentize_cat {
    for arg in "$@" ; do
        pygmentize -g "${arg}" 2> /dev/null || /bin/cat "${arg}"
    done
}

command -v pygmentize > /dev/null && alias pcat=pygmentize_cat

function ranger-cd {
  tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
    cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}

# Vim mode for zsh
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward

# Configure default compiler
export CC=gcc-last
export CXX=g++-last
export LD=g++-last

# Make sure nano isn't used
alias nano='vim'

alias tmux='TERM=screen-256color /usr/bin/tmux'

alias mbm='BMDIR=/home/wichtounet/bookmarks mbm'

alias psgrep='ps aux | grep'
