#set -e
currentdir=$PWD
myconfigpath="$HOME/.oh-my-config"
tmuxconfigpath="$HOME/.tmux"
zshconfigpath="$HOME/.oh-my-zsh"
vim_plug_file="$HOME/.vim/autoload/plug.vim"
log_info(){
    log_info_prefix="\033[34m[info]\033[0m"
    echo $log_info_prefix $1
}
log_error(){
    log_info_prefix="\033[31m[error]\033[0m"
    echo $log_info_prefix $1
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
download_config(){
    log_info 'downloading..'
    if [ -d $myconfigpath ]
    then 
        log_info 'update config'
        cd $myconfigpath
        git pull
        cd $currentdir
    else 
        log_info 'download config'
	    git clone https://git.coding.net/YGZ/oh-my-config.git ~/.oh-my-config
    fi
    if [ -d $tmuxconfigpath ]
    then 
        log_info 'update .tmux' 
        cd $tmuxconfigpath
        git pull
        cd $currentdir
    else 
        log_info 'download config'
	    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    fi
}
install_vim_config(){
    log_info 'install vim config'
    ln -s $myconfigpath/.vimrc ~
    res=$?
    if [ $res -ne 0 ]
    then 
        log_error 'install vim config failed.'
        exit
    fi
    if [ ! -f $vim_plug_file ]
    then 
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}
install_tmux_config(){
    log_info 'install tmux config'
    ln -s -f $tmuxconfigpath/.tmux.conf ~
    cp $tmuxconfigpath/.tmux.conf.local ~
    ln -s $myconfigpath/.tmux.conf ~/.tmux.conf.local.self
    echo "if '[ -f ~/.tmux.conf.local.self ]' 'source ~/.tmux.conf.local.self'" >> ~/.tmux.conf.local
}
install_shell_config(){
    log_info 'install shell config'
    ln -s $myconfigpath/.shrc ~
    echo "source ~/.shrc" >> ~/.`echo $SHELL | rev | cut -d'/' -f 1 | rev`rc
}
install_oh_my_zsh(){
    log_info 'install oh-my-zsh'
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
