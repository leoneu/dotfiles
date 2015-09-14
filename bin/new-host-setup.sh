#!/bin/bash

~/dotfiles/bin/gitconfig.sh
ln -sf $HOME/dotfiles/emacs/.emacs.d $HOME
ln -sf $HOME/dotfiles/git/.gitignore_global $HOME
ln -sf $HOME/dotfiles/tmux/.tmux.conf $HOME
ln -sf $HOME/dotfiles/tmux/.tmux $HOME
ln -sf $HOME/dotfiles/.aspell.en.pws $HOME
