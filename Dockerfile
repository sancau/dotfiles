##############################################################
# Build like this:
# docker build . -t ws --build-arg GLOBAL_PYTHON_VERSION=3.11
#
# Use like this:
# docker run -it --rm -v ${PWD}:/host ws
#
##############################################################

FROM ubuntu:22.04

SHELL ["/bin/bash", "-exo", "pipefail", "-c"]

ARG GLOBAL_PYTHON_VERSION=3.11
ENV HOME /root

# (1) install some basic tools
# (2) install pyenv build dependencies (https://github.com/pyenv/pyenv/wiki#suggested-build-environment)
RUN apt-get update &&\
    apt-get upgrade -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
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
    mkdir -p /root/.local/bin &&\
    ln -s /usr/bin/batcat /root/.local/bin/bat &&\
    pipx ensurepath

# Zsh
RUN apt-get install -y zsh &&\
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &&\
    chsh -s $(which zsh) &&\
    git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions &&\
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &&\
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git /root/.oh-my-zsh/custom/plugins/you-should-use &&\
    git clone https://github.com/fdellwing/zsh-bat.git /root/.oh-my-zsh/custom/plugins/zsh-bat

# Zoxied
RUN curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Tmux
RUN apt-get install -y tmux &&\
    git clone https://github.com/tmux-plugins/tpm /root/.tmux/plugins/tpm

# PyEnv
RUN curl https://pyenv.run | bash

# Install global Python (versin specified explicitly)
RUN export PYENV_ROOT="$HOME/.pyenv" &&\
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" &&\
    eval "$(pyenv init -)" &&\
    eval "$(pyenv virtualenv-init -)" &&\
    pyenv install ${GLOBAL_PYTHON_VERSION} &&\
    pyenv global ${GLOBAL_PYTHON_VERSION}

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - &&\
    apt-get install -y nodejs

# Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz  &&\
    rm -rf /opt/nvim &&\
    tar -C /opt -xzf nvim-linux64.tar.gz

# Install global Poetry
RUN pipx ensurepath &&\
    pipx install poetry &&\
    mkdir ~/.zfunc &&\
    /root/.local/bin/poetry completions zsh > ~/.zfunc/_poetry

COPY . /root/dotfiles
RUN cd /root/dotfiles && stow --adopt . && git checkout .

# Bootstrap
RUN locale-gen en_US.UTF-8
RUN mkdir /ws
WORKDIR /ws
ENTRYPOINT [ "zsh" ]

