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
alias chrome='open -a Google\ Chrome'
alias pyserv='python -m SimpleHTTPServer'
alias filezilla='open /Applications/FileZilla.app/'
alias profile='python -m cProfile'
alias profilec='python -m cProfile --sort=cumulative'
alias ipython='ipython --no-confirm-exit'
alias gh='git hist'

# z
. /usr/local/etc/profile.d/z.sh

# Export variables
export JYTHON_HOME="/usr/local/Cellar/jython/2.5.2/libexec"
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:/usr/local/share/python # For pip 

# SCM Breeze
[ -s "/Users/lucypark/.scm_breeze/scm_breeze.sh" ] && source "/Users/lucypark/.scm_breeze/scm_breeze.sh"
