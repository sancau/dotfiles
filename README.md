# Dotfiles

- zsh config
- nvim config
- wezterm config

# How-to

- install nvim, git, stow
- clone repository
- cd repository
- link files with stow: `stow --adopt .`

Adopt flag will overwrite all files in repository that are already present in $HOME. In this case use git to check the changes and undo if need.

