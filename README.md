# Dotfiles

![image](https://github.com/sancau/dotfiles/assets/16306443/85808b56-e432-4346-b784-c798c915382c)

## What's this

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

### WSL setup

- install WezTerm
- put `.wezterm.lua` to `C:\Users\<USER>\` (your Windows home directory)
- install AutoHotKey v2 (for Capslock to Ctrl/Esc remap and workspace open hotkey)
- put AHK script to startup directory for it to be run on boot (Win + R, type in shell:startup, put AHK script `remaps.ahk` into the opened directory)
- create fresh Ubuntu 22.04 distro in WSL v2
- install the configuration and dependencies:

```bash
wget https://raw.githubusercontent.com/sancau/dotfiles/master/install.sh
```
```bash
SSH_CREDS_DIR=/mnt/c/storage/ydisk/ws/ssh/ \
GLOBAL_PYTHON_VERSION=3.10.14 \
DOTFILES_GIT_URL=git@github.com:sancau/dotfiles.git bash install.sh
```
    - the script is mostly automatic
    - enter sudo password a few times when asked
    - select iptables mode 1 when asked

- symlink cloud directory if any (example: `ln -s /mnt/c/storage/ydisk/ws/cloud ~/cloud`)
- put `~/dotfiles/wsl.conf` to `/etc` (merge if there already is any custom config)
- configure `~/.workspaces`: each line is a full path to a directory that will be threated as a workspace
    - for example:
        - /home/myuser/dotfiles
        - /home/myuser/cloud/some_project
- quit WSL console

## Usage

`F4` - open "IDE" (workspaces select dialog)
`Alt-F4` - close "IDE"

### Additinal aliases 

Use `ws` alias to create a workspace for the current directory as a tmux session. If session already exists then re-attach.
Nvim will run in a poetry env if any. For reusable workspaces it better to use `~/.workspaces` config file

Use 'v' alias to run nvim in a poetry env if any inside or outside of a workspace.
Check `~/.zshrc` for more.

