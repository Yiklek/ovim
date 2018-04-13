currentdir=$PWD
myconfigpath="$HOME/.oh-my-config"
tmuxconfigpath="$HOME/.tmux"
zshconfigpath="$HOME/.oh-my-zsh"
check_git(){
	if command -v git >/dev/null 2>&1; then 
		echo 'exists git' 
		return 1
	else 
	    echo 'no exists git."apt install git" to install git' 
        exit -1
	fi
}
download_config(){
    echo 'downloading..'
    if [ -d $myconfigpath ]
    then 
        echo 'update config'
        cd $myconfigpath
        git pull
        cd $currentdir
    else 
        echo 'download config'
	    git clone https://git.coding.net/YGZ/oh-my-config.git ~/.oh-my-config
    fi
    if [ -d $tmuxconfigpath ]
    then 
        echo 'update .tmux' 
        cd $tmuxconfigpath
        git pull
        cd $currentdir
    else 
        echo 'download config'
	    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    fi
}
install_vim_config(){
    ln -s $myconfigpath/.vimrc ~
    res=$?
    if [ $res -ne 0 ]
    then 
        exit
    fi
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
install_tmux_config(){
    ln -s -f $tmuxconfigpath/.tmux.conf ~
    cp $tmuxconfigpath/.tmux.conf.local ~
    ln -s $myconfigpath/.tmux.conf ~/.tmux.conf.local.self
    echo "if '[ -f ~/.tmux.conf.local.self ]' 'source ~/.tmux.conf.local.self'" >> ~/.tmux.conf.local
}
install_shell_config(){
    ln -s $myconfigpath/.shrc ~
    echo "source ~/.shrc" >> ~/.`echo $SHELL | rev | cut -d'/' -f 1 | rev`rc
}
install_oh_my_zsh(){
    if [ ! -d $zshconfigpath  ]
    then 
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
}
check_git
download_config
case $1 in
    vim )
        install_vim_config
        ;;
    tmux )
        install_tmux_config 
        ;;
    shell )
        install_shell_config 
        ;;
    zsh)
        install_oh_my_zsh 
        ;;
    *)
		download_config
        install_vim_config 
        install_tmux_config 
esac
