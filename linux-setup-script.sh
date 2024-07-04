#!/bin/sh

check_installed(){
    command -v $1 >/dev/null 2>&1
}

check_which_pkgmanager(){
    list_of_pkgmanager='apt dnf'
    for pkgmgr in ${list_of_pkgmanager}; do
        if check_installed $pkgmgr; then
            PackageManager=${pkgmgr}
            echo "Using $PackageManager"
        elif [ -z "${PackageManager}" ]; then
            echo "Couldn't find a package manager"
        fi
    done

}

install_nvim(){
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root /opt/neovim
    sudo ln -s /opt/neovim/AppRun /usr/bin/nvim
}

case $(command -v apt || command -v dnf) in
    *apt)
        if check_installed zsh; then
            echo "zsh is already installed"
        else
            sudo apt install zsh
        fi
        {

        if check_installed tmux; then
            echo "tmux is already installed"
        else
            sudo apt install tmux
        fi

        if check_installed nvim; then
            echo "nvim is already installed"
        else
            install_nvim
        fi
        ;;
esac

#installStarship(){



#}

