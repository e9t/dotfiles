# Change when necessary
export HOME="$HOME"
export PATH="$PATH:$HOME/bin"

# Import constants
if [ -f ~/.bash_constants ]; then
    . ~/.bash_constants
fi

# ----------------------------------------------------------------------------
# Environment variables
# ----------------------------------------------------------------------------

# Set locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHONIOENCODING=UTF-8   # http://stackoverflow.com/a/6361471/1054939

# Tell 'ls' to be colorful
export CLICOLOR=1
export LSCOLORS='GxFxCxDxBxegedabagacedx'
pgb() {
    # Show git branch
    git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' -e 's/(master)//'
}
export PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[33m\]$(pgb)\[\033[00m\]\$ '

# Linker library
export LD_LIBRARY_PATH='/usr/local/lib'


# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# global
alias sourceb='source ~/.bashrc'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias vi='vim'
alias agi='ag --ignore-dir'
alias e2u='iconv -f euckr -t utf8'
alias ports='lsof -Pn -i4 | grep LISTEN'
alias rm='rm -i'
alias rmed='find . -type d -empty -delete'
# for many small files
alias rscp='rsync -r --ignore-existing --progress --rsh=ssh'
# for a few big files
alias rscpb='rsync -r --partial --progress --rsh=ssh'
alias tl='tree -L 2'
alias wgetr='wget -r --no-parent'
alias sshuttles='sshuttle -r lovit 0/0'

# fasd
eval "$(fasd --init bash-hook bash-ccomp bash-ccomp-install)"
alias s='fasd -si'                      # show / search / select
alias c='fasd_cd -b current'            # cd in current folder
alias cc='fasd_cd -b current -i'        # cd in current folder (interactive)
alias v='fasd -e vim -b current'        # open file in current folder
alias vv='fasd -e vim -b current -i'    # open file in current folder (interactive)
alias z='fasd_cd -d'
alias zz='fasd_cd -d -i'                # global cd (interactive)
if [ -f "$HOME/.fasdrc" ]; then
    . $HOME/.fasdrc
fi
alias f='open .' # overwrite f
alias emem='sudo bash -c "sync; echo 1 > /proc/sys/vm/drop_caches"'

# github/gist
alias gistup='gistup --remote=gist --private --'

# nvm
export NVM_DIR="$HOME/.nvm"
# NOTE: The following line is VERY SLOW
alias sourcen='. "${NVM_DIR}/nvm.sh"'

# python
alias pyserv='python -m SimpleHTTPServer'
alias pyprofile='python -m cProfile --sort=cumulative'

# tmux
alias ta='tmux attach -t lucypark || tmux new -s lucypark'
alias tw='tmux rename-window -t'

# SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# ----------------------------------------------------------------------------
# Misc
# ----------------------------------------------------------------------------

# bash history logging
if [ -d "$HOME/.logs" ]; then
    export HISTCONTROL=ignoredups:erasedups
    shopt -s histappend
    export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'
fi

# os specific
if [ "$(uname)" == "Darwin" ]; then
    if [ -f "$HOME/.bash_macosx" ]; then
        . ~/.bash_macosx
    fi
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    if [ -f "$HOME/.bash_linux" ]; then
        . ~/.bash_linux
    fi
fi

# local bash
if [ -f "$HOME/.bash_local" ]; then
    . ~/.bash_local
fi
