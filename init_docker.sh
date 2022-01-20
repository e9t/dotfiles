# common
apt update
apt install tmux git locales neovim htop ruby silversearcher-ag fasd git-lfs zsh
locale-gen en_US.UTF-8
chsh -s $(which zsh)

# for pyenv
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment
apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# for scipy
apt install libblas-dev liblapack-dev
apt install gfortran
