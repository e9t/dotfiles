# Lucy's Dotfiles

My dotfiles for bash.
Thanks to the myriad developers out there who opened up their codes!


## Installation

```
# backup previous dotfiles
mkdir -p ~/.dotfiles.backup
mv ~/.[^.]* ~/.dotfiles.backup/

# get new dotfiles
git clone --recursive https://github.com/e9t/dotfiles.git .dotfiles
ln -s .dotfiles/* .dotfiles/.[^.]* ~
```

## Features

### Bash
- Though tempted by [zsh](http://www.zsh.org/) from time to time, I'm quite content with my current [bash](http://www.gnu.org/software/bash/bash.html) settings. If I'm bored one day, I might migrate.
- [fasd](https://github.com/clvv/fasd) is a small shell scipt that should be nominated for the Nobel prize or something. (It lets you jump around directories based on your log 'frecencies'.) I once used [z](https://github.com/rupa/z).
- I maintain a `.bash_aliases`(which contains more than aliases) and `.bash_functions`. Then there's a `.bash_macosx`, `.bash_linux` and `.bash_constants`.

### Vim
- I've forked Amir Salihefendic's [basic .vimrc](https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim) and customized it (e.g., add code templates).
- `.vim` plugins are managed with [pathogen.vim](https://github.com/tpope/vim-pathogen).
- Skeleton files for C, HTML, Java, Python sometimes make my life easier (but sometimes not).

### Tmux
- My `.tmux.conf` is based on [Florian Crouzat's](http://files.floriancrouzat.net/dotfiles/.tmux.conf), where I've commented out stuff and added pane selection key bindings.

### Git
- [scm_breeze](https://github.com/ndbroadbent/scm_breeze) is a MUST-GET for git!

...and much more!

## License
You're free to use anything I did to this repo, but please respect others' licenses within.
I'm always happy for [feedback](http://twitter.com/echojuliett).
