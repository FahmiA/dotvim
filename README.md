Installation:

    git clone git@github.com:FahmiA/dotvim.git .vim

Create symlinks:

    ln -s ~/.vim/.vimrc ~/.vimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

Install plugins:

    vim +PackUpdate

