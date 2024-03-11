# Build like this:
# docker build . -t ide --build-arg GLOBAL_PYTHON_VERSION=3.11.8

# Use like this:
# docker run -it --rm -v ${PWD}:/host ide

FROM ubuntu:22.04

SHELL ["/bin/bash", "-exo", "pipefail", "-c"]

ARG GLOBAL_PYTHON_VERSION=3.11.8

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
        locales &&\
    mkdir -p ~/.local/bin &&\
    ln -s /usr/bin/batcat ~/.local/bin/bat

# Fonts
RUN wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip &&\
    unzip JetBrainsMono.zip -d ~/.fonts &&\
    rm JetBrainsMono.zip

# Zsh
RUN apt-get install -y zsh &&\
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended &&\
    chsh -s $(which zsh) &&\
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions &&\
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &&\
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.oh-my-zsh/custom/plugins/you-should-use &&\
    git clone https://github.com/fdellwing/zsh-bat.git ~/.oh-my-zsh/custom/plugins/zsh-bat &&\
    sed -i 's/\(^plugins=([^)]*\)/\1 zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat poetry/' ~/.zshrc &&\
    echo 'export LC_ALL=en_US.UTF-8' >> ~/.zshrc &&\
    echo 'export LANG=en_US.UTF-8' >> ~/.zshrc &&\
    echo 'export LC_CTYPE=en_US.UTF-8' >> ~/.zshrc

# Zoxied
RUN curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Tmux
RUN apt-get install -y tmux &&\
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# PyEnv
RUN curl https://pyenv.run | bash &&\
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc &&\
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc &&\
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc &&\
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc

# Install global Python (version specified explicitly)
RUN export PYENV_ROOT="$HOME/.pyenv" &&\
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" &&\
    eval "$(pyenv init -)" &&\
    eval "$(pyenv virtualenv-init -)" &&\
    pyenv install ${GLOBAL_PYTHON_VERSION} &&\
    pyenv global ${GLOBAL_PYTHON_VERSION}

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - &&\
    apt-get install -y nodejs

# Install global Poetry
RUN /root/.pyenv/shims/pip install poetry &&\
    mkdir ~/.oh-my-zsh/custom/plugins/poetry &&\
    /root/.pyenv/shims/poetry completions zsh > ~/.oh-my-zsh/custom/plugins/poetry/_poetry

# Neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz  &&\
    rm -rf /opt/nvim &&\
    tar -C /opt -xzf nvim-linux64.tar.gz &&\
    echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.zshrc

# NvChad
RUN git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 &&\
    export PATH="$PATH:/opt/nvim-linux64/bin" &&\
    NVCHAD_EXAMPLE_CONFIG=n nvim --headless "+q"

# Neovim Python features
# Attention: hacky trick with timeout to return 0 ^^ 
# (otherwise nvim would never execute TSInstall before quit with +qall, dunno why)
RUN rm -rf ~/.config/nvim/lua/custom &&\
    git clone https://github.com/dreamsofcode-io/neovim-python.git ~/.config/nvim/lua/custom &&\
    export PATH="$PATH:/opt/nvim-linux64/bin" &&\
    export PYENV_ROOT="$HOME/.pyenv" &&\
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH" &&\
    eval "$(pyenv init -)" &&\
    eval "$(pyenv virtualenv-init -)" &&\
    npm install -g tree-sitter-cli &&\
    nvim --headless +"MasonInstallAll" +qall &&\
    (timeout -s SIGINT 10 nvim --headless +"TSInstall python" || true)

# Aliases
RUN echo 'alias v="nvim"' >> ~/.zshrc

# Bootstrap
RUN locale-gen en_US.UTF-8
RUN mkdir /host
WORKDIR /host

ENTRYPOINT [ "zsh" ]


# Possible TODOs
################################
# ripple / alternative
# ruff
# virtualenv respect for debug?

# Tmux config
# vim tmux navigator
# colors
# windows order
# styling

# Other
# ranger?
# ranger to replace NvimTree?
# render images for preview?
# expose ports?

# Neovim custom config
# easymotion
# leader key
# tag bar (code structure)
# nerd commenter
# clipboard (yanking to system clipboard)
