# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use poetry)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export PATH="$PATH:/opt/nvim-linux64/bin:$HOME/.local/bin:$HOME/.luals/bin"

alias v="poetry run nvim . || nvim ."
alias vc="v ~/.config/nvim/init.lua"
alias zc="v ~/.zshrc"
alias zs="source ~/.zshrc"
alias lgc="v ~/.config/lazygit/config.yml"

# create a new Tmux session with the current directory as root
# if a session is already created - attach to it
alias ws='tmux new-session -d -s $(basename $(pwd)) && tmux send-keys -t $(basename $(pwd)) "poetry run nvim . || nvim ." Enter && tmux attach -t $(basename $(pwd))|| tmux attach -t $(basename $(pwd))'

export LAZYGIT_COLOR_THEME="/home/$USER/.config/lazygit/catppuccin/mocha/blue.yml"
alias lg="lazygit --use-config-file=/home/sancau/.config/lazygit/config.yml,$LAZYGIT_COLOR_THEME"
alias ld="lazydocker"

alias sb='cp ~/dotfiles/pyproject.toml . && cp ~/dotfiles/poetry.lock . && poetry install'

# zoxide
eval "$(zoxide init zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# poetry
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# other writable dirs (example: those that are on a Windows host drive) are yellow on black, files are green on black
LS_COLORS+=':ow=01;33'

# Workspaces related

# create workspace at path
spawn_ws() {
    echo "Spawning a workspace at $1"
    tmux new-session -d -s $(basename $1) -c $1 && tmux send-keys -t $(basename $1) "poetry run nvim $1 || nvim $1" Enter
}

# create workspaces from config located at path
spawn_all_ws_from_config() {
    tmux kill-server && sleep 0.1;
    for ws in $(cat $1); do spawn_ws $ws; done
}

show_workspaces() {
    local session=$(tmux ls | head -1 | sed 's/:.*//')
    (sleep 0.05; tmux choose-session -N -t $session) & tmux a -t $session
}

# create a new Tmux session with the current directory as root
# if a session is already created - attach to it
alias ws='tmux new-session -d -s $(basename $(pwd)) && tmux send-keys -t $(basename $(pwd)) "poetry run nvim . || nvim ." Enter && tmux attach -t $(basename $(pwd))|| tmux attach -t $(basename $(pwd))'
alias sws='show_workspaces'

# spawn workspaces only if not already inside one
[ -z "${TMUX}" ] && spawn_all_ws_from_config ~/.workspaces
[ -z "${TMUX}" ] && show_workspaces
