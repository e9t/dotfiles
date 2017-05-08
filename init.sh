# -----------------------------------------------
# A shell script to init servers
#
# Author: Lucy Park <me@lucypark.kr>
# Created: 2017-05-08
# -----------------------------------------------


# FILLME ----------------------------------------
HOME="$HOME"
install_dotfiles=1
install_packages=1
# -----------------------------------------------


# define paths
DEV="$HOME/dev"

# exit on fail
set -e


# start setup
if [ $install_dotfiles -eq 1 ]; then
    echo "# Install dotfiles..."
    cd $HOME
    git clone https://github.com/e9t/dotfiles.git
    mv dotfiles/* dotfiles/.[^.]* $HOME
    rmdir dotfiles
    sed -i "2s@.*@export HOME=\"$HOME\"@" $HOME/.bash_aliases
    git submodule init
    git submodule update
fi

if [ $install_packages -eq 1 ]; then
    echo "# Install packages..."
    mkdir -p $DEV
    cd $DEV
    git clone https://github.com/e9t/pkgs.git
    cd $DEV/pkgs
    git submodule init
    git submodule update
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    cd $DEV/pkgs/fasd && PREFIX=$HOME make install
    cd $DEV/pkgs/htop && ./autogen.sh && ./configure --prefix=$HOME && make && ln -s $PWD/htop $HOME/bin
    cd $DEV/pkgs/tmux && ./autogen.sh && ./configure --exec_prefix="$HOME" && make && ln -s $PWD/tmux $HOME/bin
fi

# vim:sw=4:ts=4:et
