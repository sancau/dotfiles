FROM ubuntu

RUN apt-get update && \
    apt-get install -y \
        git \
        curl \
        vim \
        build-essential \
        cmake \
        python3-dev \
        ctags \
        tmux

RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
RUN dpkg -i ripgrep_0.10.0_amd64.deb
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ENV TERM=xterm-256color

COPY .vimrc /root/
COPY .bashrc /root/
COPY .tmux.conf /root/

RUN vim +PlugInstall +qall
RUN python3 /root/.vim/plugged/YouCompleteMe/install.py --clang-completer

