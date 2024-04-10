# set env vars before running the install script:
# export SSH_CREDS_DIR
# export GLOBAL_PYTHON_VERSION
# export DOTFILES_GIT_URL

# copy ssh credentials from the given path (run this script with the env var set)
cp -r $SSH_CREDS_DIR ~/.ssh && chmod 600 ~/.ssh/*

# generic
sudo apt-get update && sudo apt-get upgrade -y

# docker install
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# WSL docker sock fix
sudo update-alternatives --config iptables  # choose option 1

sudo usermod -aG docker ${USER}
sudo service docker start

# base dependencies
sudo apt-get update &&\
    sudo apt-get upgrade -y &&\
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y \
        curl \
        git \
        stow \
        ripgrep \
        wget \
        zip \
        htop \
        bat \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev \
        locales \
        pipx \
        python3.11-venv \
        python3-tk \
        tk-dev &&\
    mkdir -p $HOME/.local/bin &&\
    ln -s /usr/bin/batcat $HOME/.local/bin/bat &&\
    pipx ensurepath

# Zsh
sudo apt-get install -y zsh &&\
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &&\
    chsh -s $(which zsh) &&\
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions &&\
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &&\
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $HOME/.oh-my-zsh/custom/plugins/you-should-use &&\
    git clone https://github.com/fdellwing/zsh-bat.git $HOME/.oh-my-zsh/custom/plugins/zsh-bat

# Zoxied
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Tmux
sudo apt-get install -y tmux &&\
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# PyEnv
curl https://pyenv.run | bash

# Install global Python (versin specified explicitly)
export PYENV_ROOT="$HOME/.pyenv" &&\
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" &&\
    eval "$(pyenv init -)" &&\
    eval "$(pyenv virtualenv-init -)" &&\
    pyenv install ${GLOBAL_PYTHON_VERSION} &&\
    pyenv global ${GLOBAL_PYTHON_VERSION}

# Install NodeJS
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo bash && sudo apt-get install nodejs -y

# Neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz  &&\
    rm -rf /opt/nvim &&\
    sudo tar -C /opt -xzf nvim-linux64.tar.gz &&\
    rm nvim-linux64.tar.gz

# Install global Poetry
pipx ensurepath &&\
    pipx install poetry &&\
    mkdir $HOME/.zfunc &&\
    $HOME/.local/bin/poetry completions zsh > $HOME/.zfunc/_poetry

# clone dotfiles repo (env var must be set!)
cd ~ && git clone $DOTFILES_GIT_URL
# symlink dotfiles
cd ~/dotfiles && stow --adopt .

# install tmux plugins
tmux start-server &&\
    tmux new-session -d &&\
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh &&\
    tmux kill-server

# locale
sudo locale-gen en_US.UTF-8

# Mason install, Lazy install, poetry deps for repl, etc