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


os=$(uname)

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

# start setup
if [ $install_dotfiles -eq 1 ]; then
    echo "# Install dotfiles..."
    set -x  # start debug mode
    cd $home

    # clone dotfiles if not exists
    if [[ ! -f "$home/.zshrc" ]]; then
        git clone https://github.com/e9t/dotfiles.git
        mv dotfiles/* dotfiles/.[^.]* $home || echo "dotfiles already exist"
        rmdir dotfiles
    fi

    # replace "$HOME with $home"
    if [[ $os == "Linux" ]]; then
        sed -i "5s@.*@export HOME=\"$home\"@" $home/.zshrc
    elif [[ $os == "Darwin" ]]; then
        sed -i '' "5s@.*@export HOME=\"$home\"@" $home/.zshrc
    fi

    # update submodules
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
    pyenv install 3.7.3
    pyenv global 3.7.3

    # Enable pyenv-virtualenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
    eval "$(pyenv virtualenv-init -)"

    # Install python packages
    pip install ipython flake8 gpustat tensorflow-gpu tensorboard konlpy

    # For CentOS 7
    # NOTE: tmux install by yum installs v1.8, will need manual install
    if [[ $os == "Linux" ]]; then
        sudo yum install the_silver_searcher htop fasd git-lfs tmux
    elif [[ $os == "Darwin" ]]; then  # Mac OSX
        # Install Homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew install fasd
    fi
    set +x
fi

# vim:sw=4:ts=4:et
