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
#alias ipython='ipython --no-confirm-exit'
alias gh='git hist'
alias gae='dev_appserver.py --port=8192 .'
alias gaeup='appcfg.py update .'
alias ld3py='ln -s ~/dev/pkgs/d3py-0.2.3/d3py'
alias start_mongo='mongod --fork'
alias stop_mongo='killall -SIGTERM mongod 2>/dev/null'
alias status_mongo="killall -0 mongod 2>/dev/null; if [ \$? -eq 0 ]; then echo 'started'; else echo 'stopped'; fi"

# z
. /usr/local/etc/profile.d/z.sh

# Export variables
export JYTHON_HOME="/usr/local/Cellar/jython/2.5.2/libexec"
PATH=$PATH:$HOME/.rvm/bin                                   # For RVM scripting
PATH=$PATH:/usr/local/share/python                          # For pip 
PATH=$PATH:/usr/texbin                                      # For TeX
PATH=$PATH:/usr/local/texlive/2012/bin/universal-darwin     # For TeX

# SCM Breeze
[ -s "/Users/lucypark/.scm_breeze/scm_breeze.sh" ] && source "/Users/lucypark/.scm_breeze/scm_breeze.sh"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Unicode printing functions
ucat() {
  native2ascii -encoding UTF-8 -reverse $1
}

uhead() {
  head $1 | native2ascii -encoding UTF-8 -reverse
}
