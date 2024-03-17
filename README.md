# Dotfiles

## Setup

- install curl, zsh, omzsh, nvim, git, stow, tmux, nodejs, lazygit, lazydocker, tpm
- clone repository
- cd repository
- link files with stow: `stow --adopt .`

Adopt flag will overwrite all files in repository that are already present in $HOME. In this case use git to check the changes and undo if need.

## Usage

Use `ws` alias to create a workspace for the current directory as a tmux session. If session already exists then re-attach.
