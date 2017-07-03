#!/bin/bash

# -----------------------------------------------
# A shell script to init servers
#
# Author: Lucy Park <me@lucypark.kr>
# Created: 2017-05-08
# -----------------------------------------------

set -euo pipefail

# FILLME ----------------------------------------
home="$HOME"
install_dotfiles=1
install_packages=1
# -----------------------------------------------

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
read -r -p "This is your last warning. [y/N] " response
if ! [[ $response == "y" ]]; then
  echo "Aborting..."
  exit 0
fi
for i in {5..1}; do
    echo $i
    sleep 1
done

# define paths
DEV="$home/dev"

# start setup
if [ $install_dotfiles -eq 1 ]; then
    echo "# Install dotfiles..."
    set -x  # start debug mode
    cd $home
    git clone https://github.com/e9t/dotfiles.git
    mv dotfiles/* dotfiles/.[^.]* $home
    rmdir dotfiles
    sed -i "2s@.*@export HOME=\"$home\"@" $home/.bash_aliases
    git submodule init
    git submodule update
    set +x
fi

if [ $install_packages -eq 1 ]; then
    echo "# Install packages..."
    set -x  # start debug mode
    mkdir -p $DEV
    cd $DEV
    git clone https://github.com/e9t/pkgs.git
    cd $DEV/pkgs
    git submodule init
    git submodule update
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    cd $DEV/pkgs/fasd && PREFIX=$home make install
    cd $DEV/pkgs/htop && ./autogen.sh && ./configure --prefix=$home && make && ln -s $PWD/htop $home/bin
    cd $DEV/pkgs/tmux && ./autogen.sh && ./configure --exec_prefix="$home" && make && ln -s $PWD/tmux $home/bin
    set +x
fi

pip install gpustat

# vim:sw=4:ts=4:et
