# Dotfiles

## What it is

A complete terminal-based IDE setup for Python based on Neovim, Poetry, Tmux, Pyenv, Lazygit an other tools/plugins

Features:

- Clean look and feel
- Python specifics
    - linting
    - formatting
    - autocomplete
    - type checking
    - test runners
    - debugger
    - REPL
- Tmux-based
- Lazygit integrated
- workspaces separation via Tmux

## Setup

Tested on:

- WSL Ubuntu 22.04

On a fresh Ubuntu 22.04 installation run the install script. Example:

```bash
SSH_CREDS_DIR=/mnt/c/storage/ydisk/ws/ssh/ \
GLOBAL_PYTHON_VERSION=3.10.14 \
DOTFILES_GIT_URL=git@github.com:sancau/dotfiles.git \
wget https://rawgithubusercontent.com/sancau/dotfiles/master/install.sh | bash
```
Restart WSL console.

Also a Dockerfile is available but it needs some polishing.

## Usage

Use `ws` alias to create a workspace for the current directory as a tmux session. If session already exists then re-attach.
Nvim will run in a poetry env if any. 
Use 'v' alias to run nvim in a poetry env if any inside or outside of a workspace.

