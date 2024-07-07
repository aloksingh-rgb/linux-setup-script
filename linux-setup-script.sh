#!/bin/sh
: '
check if .config exists
if I am calling to move new configs anyways then just add the move config functions into the case statements'


GITHUB_DIR=$(pwd)

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

check_dot_config(){
    if [[ -e "$HOME/.config" ]]; then
        echo ".config exists"
    else
        echo ".config doesnot exists, make a .config dir"
        exit 1
    fi
}

install_nvim(){
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract
    sudo mv squashfs-root /opt/neovim
    sudo ln -s /opt/neovim/AppRun /usr/bin/nvim
}

install_starship(){
    if ! curl -sS https://starship.rs/install.sh | sh; then
        echo -e "Something went wrong during starship install!"
        exit 1
    fi
}


change_bashrc(){
    $USER_HOME=$HOME
    ## Check if a bashrc file is already there.
    OLD_BASHRC="${USER_HOME}/.bashrc"
    if [[ -e ${OLD_BASHRC} ]]; then
        echo -e "Changing old bash config file to ${USER_HOME}/.bashrc.bak"
        if ! mv ${OLD_BASHRC} ${USER_HOME}/.bashrc.bak; then
            echo -e "Can't mv the old bash config file!"
            exit 1
        fi
    fi
}

change_zshrc(){
    $USER_HOME=$HOME
    ## Check if a zshrc file is already there.
    OLD_ZSHRC="${USER_HOME}/.zshrc"
    if [[ -e ${OLD_ZSHRC} ]]; then
        echo -e "Changing old zsh config file to ${USER_HOME}/.zshrc.bak"
        if ! mv ${OLD_ZSHRC} ${USER_HOME}/.zshrc.bak; then
            echo -e "Can't mv the old zsh config file!"
            exit 1
        fi
    fi
}

put_new_zshrc(){
    mv $HOME/.config/.zshrc $HOME/.config/.zshrc.bak
    mv $GITHUB_DIR/".zshrc" $HOME/.config/
    echo "I am in put_new_zshrc."
}


put_new_tmux_conf(){
    mv $HOME/.config/.tmux.conf $HOME/.config/.tmux.conf.bak
    mv $GITHUB_DIR/".tmux.conf" $HOME/.config/
}



put_new_starship_toml(){
    mv $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
    mv $GITHUB_DIR/"starship.toml" $HOME/.config/
}


put_new_nvim_conf(){
    if [[ -e "$HOME/.config/nvim" ]]; then
        echo "nvim dir already exists in .config"
        mv $HOME/.config/nvim $HOME/.config/old_nvim
        mv $GITHUB_DIR/nvim $HOME/.config/
    fi

}

case $(command -v apt || command -v dnf) in
    *apt)

        if check_dot_config; then
            echo "checked the existence of .config, now starting the case statement"
        fi
            

        if check_installed zsh; then
            echo "zsh is already installed"
             
        else
            echo "installing zsh"
            sudo apt install zsh
        fi

        put_new_zshrc

        if check_installed tmux; then
            echo "tmux is already installed"
        else
            echo "installing tmux"
            sudo apt install tmux
        fi

        put_new_tmux_conf

        if check_installed nvim; then
            echo "nvim is already installed"
        else
            echo "installing nvim"
            install_nvim
        fi

        put_new_nvim_conf
        
        if check_installed starship; then
            echo "starship is already installed"
        else
            echo "installing starship"
            install_starship
        fi

        put_new_starship_toml

        change_bashrc
        ;;
esac

