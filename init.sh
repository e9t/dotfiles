# -----------------------------------------------
# A shell script to init servers
#
# Author: Lucy Park <me@lucypark.kr>
# Created: 2017-05-08
# -----------------------------------------------


# FILLME ----------------------------------------
HOMEC="$HOME"
install_dotfiles=1
install_packages=1
# -----------------------------------------------


# confirm home
read -r -p "Is \$HOME supposed to be \"$HOMEC\"? [y/N] " response
if ! [[ $response == "y" ]]; then
  echo "Aborting..."
  exit 0
fi

# define paths
DEV="$HOMEC/dev"

# exit on fail
set -e

# start setup
if [ $install_dotfiles -eq 1 ]; then
    echo "# Install dotfiles..."
    cd $HOMEC
    git clone https://github.com/e9t/dotfiles.git
    mv dotfiles/* dotfiles/.[^.]* $HOMEC
    rmdir dotfiles
    sed -i "2s@.*@export HOME=\"$HOMEC\"@" $HOMEC/.bash_aliases
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
    cd $DEV/pkgs/fasd && PREFIX=$HOMEC make install
    cd $DEV/pkgs/htop && ./autogen.sh && ./configure --prefix=$HOMEC && make && ln -s $PWD/htop $HOMEC/bin
    cd $DEV/pkgs/tmux && ./autogen.sh && ./configure --exec_prefix="$HOMEC" && make && ln -s $PWD/tmux $HOMEC/bin
fi

# vim:sw=4:ts=4:et
