#!/bin/bash

# -----------------------------------------------
# A shell script to init servers
#
# Author: Lucy Park <me@lucypark.kr>
# Created: 2017-05-08
# Requirements: libevent, ncurses for tmux
# Usage:
#
#   wget http://bit.ly/inite9t
#   bash inite9t
# -----------------------------------------------

set -euo pipefail

# FILLME ----------------------------------------
home="$HOME"
install_dotfiles=1
install_packages=1
# -----------------------------------------------

clone_repo_if_not_exists() {
    git clone $1 || echo "repo already exists"
}

# confirm home
read -r -p "Is \$HOME supposed to be \"$home\"? [y/N] " response
if ! [[ $response == "y" ]]; then
  read -r -p "Enter a new \$HOME: " home
fi
read -r -p "Are you sure about this? [y/N] " response
if ! [[ $response == "y" ]]; then
  echo "Aborting..."
  exit 0
fi
for i in {5..1}; do
    echo $i
    sleep 1
done

os=$(uname)
# start setup
if [ $install_dotfiles -eq 1 ]; then
    echo "# Install dotfiles..."
    set -x  # start debug mode
    cd $home
    clone_repo_if_not_exists https://github.com/e9t/dotfiles.git
    mv dotfiles/* dotfiles/.[^.]* $home || echo "dotfiles already exist"
    rmdir dotfiles
    if [[ $os == "Linux" ]]; then
        sed -i "2s@.*@export HOME=\"$home\"@" $home/.bash_aliases
    elif [[ $os == "Darwin" ]]; then
        sed -i '' "2s@.*@export HOME=\"$home\"@" $home/.bash_aliases
    fi
    git submodule init
    git submodule update

    set +x
fi

if [ $install_packages -eq 1 ]; then
    echo "# Install packages..."
    set -x  # start debug mode

    # Start pyenv and install python
    export PYENV_ROOT="$home/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    pyenv install 2.7.13
    pyenv install 3.6.1
    pyenv global 2.7.13 3.6.1

    # Enable pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    eval "$(pyenv virtualenv-init -)"

    # Install python packages
    pip install ipython flake8 gpustat tensorflow-gpu tensorboard konlpy

    # For CentOS 7
    # NOTE: tmux install by yum installs v1.8, will need manual install
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo yum install the_silver_searcher htop fasd git-lfs tmux
    elif [[ "$OSTYPE" == "darwin"* ]]; then  # Mac OSX
        # Install Homebrew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install fasd
    fi
    set +x
fi

# vim:sw=4:ts=4:et
