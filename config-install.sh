#! /bin/bash
#set -e
current_dir=$PWD
my_config_path="$HOME/.oh-my-config"
tmux_config_path="$HOME/.tmux"
zsh_config_path="$HOME/.oh-my-zsh"
vim_plug_file="$HOME/.vim/autoload/plug.vim"
flag_my_config=false
flag_tmux=false
flag_vim=false
flag_zsh=false
flag_shrc=false
# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi
log_info(){
    log_info_prefix="${BLUE}[info] ${NORMAL} %s\n"
    printf "$log_info_prefix" "$1"
}
log_error(){
    log_error_prefix="${RED}[error]${NORMAL} %s\n"
    printf "$log_error_prefix" "$1"
}

log_ok(){
    log_ok_prefix="${GREEN}[ ok ] ${NORMAL} %s\n"
    printf "$log_ok_prefix" "$1"
}
check_git(){
    log_info 'check git'
    if command -v git >/dev/null 2>&1; then
        log_info 'exists git'
    else
        log_error 'no exists git."apt install git" to install git'
        exit 1
    fi
}
check_curl(){
    log_info 'check curl'
    if command -v curl >/dev/null 2>&1; then
        log_info 'exists curl'
    else
        log_error 'no exists curl."apt install git" to install git'
        exit 1
    fi
}
download_config(){
    log_info 'downloading..'
    if [ -d $my_config_path ]
    then
        log_info 'update config'
        cd $my_config_path
        git pull
        git submodule update --recursive
        cd $current_dir
    else
        log_info 'download config'
        git clone --recursive https://git.coding.net/YGZ/oh-my-config.git ~/.oh-my-config
    fi
    #if [ -d $tmux_config_path ]
    #then
    #log_info 'update .tmux'
    #cd $tmux_config_path
    #git pull
    #cd $current_dir
    #else
    #log_info 'download config'
    #git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    #fi
}
install_nvim_config(){
    log_info 'install nvim config'
    if [ ! -d ~/.config/nvim ]
    then
        log_info 'make nvim dir'
        rm -rf ~/.vim
        mkdir -p  ~/.config/nvim
    fi
    if [ ! -f $HOME/.config/nvim/init.vim  ]
    then
        ln -s $my_config_path/vim/vimrc ~/.config/nvim/init.vim
    else
        log_error "install nvim config failed."$HOME/.config/nvim/init.vim" has existed"
    fi
    if [ ! -d $HOME/.config/nvim/config  ]
    then
        ln -s $my_config_path/vim/config ~/.config/nvim/
    else
        log_error "install nvim config failed."$HOME/.config/nvim/config" has existed"
    fi
    if [ ! -d $HOME/.config/nvim/ovim  ]
    then
        ln -s $my_config_path/vim/ovim ~/.config/nvim/
    else
        log_error "install nvim config failed."$HOME/.config/nvim/ovim" has existed"
    fi
    #    res=$?
    #    if [ $res -ne 0 ]
    #    then
    #        log_error 'install vim config failed.'
    #        exit
    #    fi
    if [ ! -f $HOME/.config/nvim/autoload/plug.vim ]
    then
        curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        log_error "install vim-plug failed."$vim_plug_file" has existed"
    fi
    if [ ! -f $HOME/.config/nvim/config-help.txt  ]
    then
        ln -s $my_config_path/vim/config-help.txt ~/.config/nvim/config-help.txt
    else
        log_error "install nvim config failed."$HOME/.config/nvim/config-help.txt" has existed"
    fi
}
clean_nvim_config(){
    if [ -f $HOME/.config/nvim/init.vim  ]
    then
        rm $HOME/.config/nvim/init.vim
    fi

    if [ -d $HOME/.config/nvim/config  ]
    then
        rm -rf $HOME/.config/nvim/config
    fi
    if [ -d $HOME/.config/nvim/ovim  ]
    then
        rm -rf $HOME/.config/nvim/ovim
    fi
    if [ -f $HOME/.config/nvim/autoload/plug.vim ]
    then
        rm $HOME/.config/nvim/autoload/plug.vim
    fi

    if [ -f $HOME/.config/nvim/config-help.txt  ]
    then
        rm $HOME/.config/nvim/config-help.txt
    fi
}
install_vim_config(){
    log_info 'install vim config'
    if [ ! -d ~/.vim ]
    then
        log_info 'make .vim dir'
        rm -rf ~/.vim
        mkdir ~/.vim
    fi
    if [ ! -f $HOME/.vim/vimrc  ]
    then
        ln -s $my_config_path/vim/vimrc ~/.vim
    else
        log_error "install vim config failed."$HOME/.vim/vimrc" has existed"
    fi
    if [ ! -d $HOME/.vim/config  ]
    then
        ln -s $my_config_path/vim/config ~/.vim/
    else
        log_error "install vim config failed."$HOME/.vim/config" has existed"
    fi
    if [ ! -d $HOME/.vim/ovim  ]
    then
        ln -s $my_config_path/vim/ovim ~/.vim/
    else
        log_error "install vim config failed."$HOME/.vim/ovim" has existed"
    fi
    #    res=$?
    #    if [ $res -ne 0 ]
    #    then
    #        log_error 'install vim config failed.'
    #        exit
    #    fi
    if [ ! -f $vim_plug_file ]
    then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        log_error "install vim-plug failed."$vim_plug_file" has existed"
    fi
    if [ ! -f $HOME/.vim/config-help.txt  ]
    then
        ln -s $my_config_path/vim/config-help.txt ~/.vim/config-help.txt
    else
        log_error "install vim config failed."$HOME/.vim/config-help.txt" has existed"
    fi
}
clean_vim_config(){
    if [ -f $HOME/.vim/vimrc  ]
    then
        rm $HOME/.vim/vimrc
    fi

    if [ -d $HOME/.vim/config  ]
    then
        rm $HOME/.vim/config
    fi
    if [ -d $HOME/.vim/ovim  ]
    then
        rm $HOME/.vim/ovim
    fi
    if [ -f $vim_plug_file ]
    then
        rm $vim_plug_file
    fi

    if [ -f $HOME/.vim/config-help.txt  ]
    then
        rm $HOME/.vim/config-help.txt
    fi
}
install_tmux_config(){
    log_info 'install tmux config'
    if [ ! -f $HOME/.tmux.conf ]
    then
        ln -s $my_config_path/tmux/.tmux/.tmux.conf $HOME
    else
        log_error "install .tmux failed."$HOME/tmux/.tmux.conf" has existed"
    fi
    if [ ! -f $HOME/.tmux.conf.local ]
    then
        cp $my_config_path/tmux/.tmux/.tmux.conf.local $HOME
        echo "if '[ -f ~/.tmux.conf.local.self ]' 'source ~/.tmux.conf.local.self'" >> ~/.tmux.conf.local
    else
        log_error "install .tmux failed."$HOME/.tmux.conf.local" has existed"
    fi
    if [ ! -f $HOME/.tmux.conf.local.self ]
    then
        ln -s $my_config_path/tmux/.tmux.conf $HOME/.tmux.conf.local.self
    else
        log_error "install tmux config failed."$HOME/.tmux.conf.local.self" has existed"
    fi

}
clean_tmux_config(){
    if [ -f $HOME/.tmux.conf ]
    then
        rm $HOME/.tmux.conf
    fi

    if [ -f $HOME/.tmux.conf.local ]
    then
        rm "$HOME/.tmux.conf.local"
    fi

    if [ -f $HOME/.tmux.conf.local.self ]
    then
        rm "$HOME/.tmux.conf.local.self"
    fi
}
install_oh_my_zsh(){
    log_info 'install oh-my-zsh'
    if [ ! -d $zsh_config_path  ]
    then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
}
clean_oh_my_zsh_config(){
    if [ -d $zsh_config_path  ]
    then
        rm -rf ~/.oh-my-zsh
    fi
    if [ -f $HOME/.zshrc  ]
    then
        rm $HOME/.zshrc
    fi
}
install_shell_config(){
    log_info 'install shell config'
    shell_rc=~/.`echo $SHELL | rev | cut -d'/' -f 1 | rev`rc
    if [ $1 ]; then
        shell_rc=~/.$1rc
        log_info "set shell config $shell_rc"
    fi
    if [ ! -f $HOME/.rc.sh ]
    then
        ln -s $my_config_path/shell/.rc.sh $HOME
    else
        log_error "install .rc.sh config failed."$HOME/.rc.sh" has existed"
        return
    fi
    if cat $shell_rc | grep "source ~/.rc.sh">/dev/null
    then
        log_info "source config has been wrote"
    else
        log_info "add source"
        echo "source ~/.rc.sh" >> $shell_rc
    fi
    . $HOME/.rc.sh
}
clean_shell_config(){
    if [ -f $HOME/.rc.sh ]
    then
        rm $HOME/.rc.sh
    fi
}
command_help(){
    cat <<- EOF
    vim: install vim-plug,vim config
    tmux: install tmux config
    zsh: install oh-my-zsh
    shell: install shell config.run this command after zsh
    pull: update git repo
    update: update git repo
    clean:clean all installed config
EOF
    exit 0
}
check_git
check_curl
case $1 in
    vim )
        install_vim_config
        ;;
    nvim )
        install_nvim_config
        ;;
    tmux )
        install_tmux_config
        ;;
    shell )
        clean_shell_config
        install_shell_config $2
        ;;
    zsh)
        install_oh_my_zsh
        ;;
    pull)
        download_config
        ;;
    update)
        download_config
        ;;
    clean)
        clean_vim_config
        clean_nvim_config
        clean_tmux_config
        clean_shell_config
        clean_oh_my_zsh_config
        ;;
    help)
        command_help
        ;;
    *)
	download_config
        command_help
esac
