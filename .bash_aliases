# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Tell 'ls' to be colorful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacedx
export PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Source 'Generic Colourizer' from brew
# source "`brew --prefix`/etc/grc.bashrc" 

# Make the `rm` command as for confirmation
alias rm='rm -i'
alias tl='tree -L 2'
alias pop='ssh lucypark@popong.com'
alias dmlab='ssh lucypark@lucypark.net'
alias gitundo='git reset --soft HEAD^'
alias chrome='open -a Google\ Chrome'

export JYTHON_HOME="/usr/local/Cellar/jython/2.5.2/libexec"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
