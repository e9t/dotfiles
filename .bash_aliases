# iterm2
# . ~/.iterm2_shell_integration.bash

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Tell 'ls' to be colorful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacedx

# Show git branch
pgb() {
    git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' -e 's/(master)//'
}
export PS1='\n\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[33m\]$(pgb)\[\033[00m\]\$ '
# PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
# export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE};"

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Set locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHONIOENCODING=UTF-8   # http://stackoverflow.com/a/6361471/1054939

# Tons of misc aliases
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias rm='rm -i'
alias tl='tree -L 2'
alias vi='/usr/local/bin/vim'
alias pyserv='python -m SimpleHTTPServer'
alias profile='python -m cProfile'
alias profilec='python -m cProfile --sort=cumulative'
alias python='hilite time python'
alias python3='time python3'
alias gae='dev_appserver.py --port=8192 .'
alias gaeup='appcfg.py update .'
alias gistc='git clone git@gist.github.com:'
alias gistup="gistup --private --"
alias ld3py='ln -s ~/dev/pkgs/d3py-0.2.3/d3py'
alias start_mongo='mongod --fork'
alias stop_mongo='killall -SIGTERM mongod 2>/dev/null'
alias status_mongo="killall -0 mongod 2>/dev/null; if [ \$? -eq 0 ]; then echo 'started'; else echo 'stopped'; fi"
alias start_pg='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias stop_pg='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias status_pg='pg_ctl -D /usr/local/var/postgres status'
alias agi="ag --ignore-dir"
alias ports="lsof -Pn -i4 | grep LISTEN"
alias duh='du -d 0 -h'
alias duhs='du -hs * | gsort -h'
alias mvn_sources='mvn eclipse:eclipse -DdownloadSources -DdownloadJavadocs'
alias rmed='find . -type d -empty -delete'
alias spark='$HOME/dev/pkgs/java/spark-1.2.1/bin/pyspark'
alias tsvcut="csvcut -t"
alias ipynote='ipython notebook --notebook-dir="~/dev"'
# rsync -e ssh -avz some/dir/. epark@remote:dir/. # http://sr128.org/blog/?p=90
# for a few big files
alias rscpb="rsync --partial --progress --rsh=ssh"
# for many small files
alias rscp="rsync --progress --ignore-existing --rsh=ssh"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias sourceb="source ~/.bashrc"
alias bayes="cd ~/Dropbox/references/books/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers; ipython notebook"
alias e2u="iconv -f euckr -t utf8"
#alias tmux_clean="tmux kill-session -a -t `tmux display-message -p "#S"`"
alias trw="tmux rename-window"

# Open apps
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias skim="open -a Skim"
alias subl='reattach-to-user-namespace open -a /Applications/Sublime\ Text.app'

# Server aliases
alias s_merci='autossh -M 10024 epark@merci -t "tmux attach"'
alias s_pam='autossh -M 10025 e9t@pamplona -t "tmux attach"'
alias s_43="ssh nhn -t 43"
alias s_43s="ssh nhn -t 43s"

# Set paths
# [Change Java versions](http://superuser.com/a/731099/137947)
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

# MacTeX
PATH=$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin
export JYTHON_HOME=/usr/local/Cellar/jython/2.7.0/libexec

# SCM Breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# export RBENV_ROOT=/usr/local/opt/rbenv

# fasd
alias s='fasd -si'                      # show / search / select
alias c='fasd_cd -b current'            # cd in current folder
alias cc='fasd_cd -b current -i'        # cd in current folder (interactive)
alias v='fasd -e vi -b current'        # open file in current folder
alias vv='fasd -e vi -b current -i'    # open file in current folder (interactive)
alias zz='fasd_cd -d -i'                # global cd (interactive)
eval "$(fasd --init auto)"
. ~/.fasdrc
alias f="open ." # overwrite f

# [virtualenvwrapper](https://virtualenvwrapper.readthedocs.org/en/latest/)
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
# export WORKON_HOME=~/envs
# mkdir -p $WORKON_HOME
# source /usr/local/bin/virtualenvwrapper.sh

# [autoenv](https://github.com/kennethreitz/autoenv)
# source `which activate.sh`

# nvm
export NVM_DIR="$HOME/.nvm"
# NOTE: The following line is VERY SLOW
# . "$(brew --prefix nvm)/nvm.sh"
