# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Tell 'ls' to be colorful
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacedx
pgb() {
    git branch --no-color | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' -e 's/(master)//'
}
export PS1='\n\[\033[01;35m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[33m\]$(pgb)\[\033[00m\]\$ '

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Set locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHONIOENCODING=UTF-8   # http://stackoverflow.com/a/6361471/1054939

# Source 'Generic Colourizer' from brew
# source "`brew --prefix`/etc/grc.bashrc" 

# Make the `rm` command as for confirmation
alias rm='rm -i'
alias tl='tree -L 2'
alias pop='ssh lucypark@115.68.110.88'
alias dada='ssh epark@dada -t tmux'
alias daca='ssh epark@daca -t tmux'
alias merci='autossh -M 10024 epark@merci -t "tmux attach"'
alias dmweb="ssh epark@dm.snu.ac.kr -t tmux"
alias chrome='open -a Google\ Chrome'
alias safari='open -a Safari'
alias pyserv='python -m SimpleHTTPServer'
alias filezilla='open /Applications/FileZilla.app/'
alias profile='python -m cProfile'
alias profilec='python -m cProfile --sort=cumulative'
alias python='hilite time python'
alias python3='time python3'
alias gae='dev_appserver.py --port=8192 .'
alias gaeup='appcfg.py update .'
alias gist='git clone git@gist.github.com:'
alias ld3py='ln -s ~/dev/pkgs/d3py-0.2.3/d3py'
alias start_mongo='mongod --fork'
alias stop_mongo='killall -SIGTERM mongod 2>/dev/null'
alias status_mongo="killall -0 mongod 2>/dev/null; if [ \$? -eq 0 ]; then echo 'started'; else echo 'stopped'; fi"
alias start_pg='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias stop_pg='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias status_pg='pg_ctl -D /usr/local/var/postgres status'
alias gw='open http://localhost:1234/?o=age'
alias excel='reattach-to-user-namespace open -a /Applications/Microsoft\ Office\ 2011/Microsoft\ Excel.app'
alias subl='reattach-to-user-namespace subl'
alias open='reattach-to-user-namespace open'
alias gitk='reattach-to-user-namespace gitk'
alias terminal-notifier='reattach-to-user-namespace terminal-notifier'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias f="open ."
alias gistup="gistup --private --"
alias venv="source venv/bin/activate"
alias agi="ag --ignore-dir"
alias ports="sudo netstat -plnt"
alias duh='du -d 0 -h'
alias duhs='du -hs * | gsort -h'
alias mvn_sources='mvn eclipse:eclipse -DdownloadSources -DdownloadJavadocs'
alias rmed='find . -type d -empty -delete'
alias spark='/Users/e9t/dev/pkgs/java/spark-1.2.1/bin/pyspark'
# rsync -e ssh -avz some/dir/. epark@remote:dir/. # http://sr128.org/blog/?p=90
alias tsvcut="csvcut -t"
alias ipynote='ipython notebook --notebook-dir="~/dev"'
# for a few big files
alias rscpb="rsync --partial --progress --rsh=ssh"
# for many small files
alias rscp="rsync --progress --ignore-existing --rsh=ssh"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias sourceb="source ~/.bashrc"
alias bayes="cd ~/Dropbox/references/books/Probabilistic-Programming-and-Bayesian-Methods-for-Hackers; ipython notebook"
alias e2u="iconv -f euckr -t utf8"
#alias tmux_clean="tmux kill-session -a -t `tmux display-message -p "#S"`"
alias nw="vi /Users/e9t/dev/sites/lucypark.kr/source/_docs/others/numberworks.markdown"


# [Export variables](http://superuser.com/a/731099/137947)
export JYTHON_HOME="/usr/local/Cellar/jython/2.5.2/libexec"
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}
PATH=$PATH:$HOME/.rvm/bin                                   # For RVM scripting
PATH=$PATH:/usr/texbin                                      # For TeX
PATH=$PATH:/usr/local/texlive/2012/bin/universal-darwin     # For TeX
PATH=/usr/local/sbin:$PATH                                  # For Homebrew

# SCM Breeze
[ -s "/Users/e9t/.scm_breeze/scm_breeze.sh" ] && source "/Users/e9t/.scm_breeze/scm_breeze.sh"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export RBENV_ROOT=/usr/local/opt/rbenv

# Timing
PROMPT_TITLE='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
export PROMPT_COMMAND="${PROMPT_COMMAND} ${PROMPT_TITLE};"

# z
. /Users/e9t/bin/z/z.sh

# torch
export PATH=/Users/e9t/torch/install/bin:$PATH  # Added automatically by torch-dist
export LD_LIBRARY_PATH=/Users/e9t/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist

export PATH=/Users/e9t/torch/install/bin:$PATH  # Added automatically by torch-dist
export LD_LIBRARY_PATH=/Users/e9t/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist

# jython
export JYTHON_HOME=/usr/local/Cellar/jython/2.7.0/libexec

# heroku toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# [virtualenvwrapper](https://virtualenvwrapper.readthedocs.org/en/latest/)
export WORKON_HOME=~/envs
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh

# [autoenv](https://github.com/kennethreitz/autoenv)
source /usr/local/opt/autoenv/activate.sh

# julia
export PATH="$PATH:/Applications/Julia-0.3.11.app/Contents/Resources/julia/bin"

# selenium
export PATH="$PATH:$HOME/bin"

# numba
export LLVM_CONFIG="/usr/local/Cellar/llvm/3.6.2/bin/llvm-config"

# torch
export PATH=/Users/e9t/torch/install/bin:$PATH  # Added automatically by torch-dist
export LD_LIBRARY_PATH=/Users/e9t/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist
export PATH=/Users/e9t/torch/install/bin:$PATH  # Added automatically by torch-dist
export LD_LIBRARY_PATH=/Users/e9t/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist

# spark
export SPARK_HOME="$HOME/dev/pkgs/java/spark-1.2.1"

# aws
export EC2_HOME="/usr/local/ec2/ec2-api-tools-1.7.5.1"
export PATH="$PATH:$EC2_HOME/bin"
export EC2_URL="https://ec2.ap-northeast-2.amazonaws.com"

if [ -f  ~/.bash_aws ]; then
    . ~/.bash_nw
fi
