curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo apt install build-essential cmake python3-dev
sudo apt install -y lxd lxd-clients
sudo apt install ctags
sudo apt install ripgrep
vim -c "PlugInstall --sync" +qa
python3 ~/.vim/plugged/YouCompleteMe/install.py --clang-completer
