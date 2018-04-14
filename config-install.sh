#!/bin/bash
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
download_config(){
    log_info 'downloading..'
    if [ -d $my_config_path ]
    then 
        log_info 'update config'
        cd $my_config_path
        git pull
        cd $current_dir
    else 
        log_info 'download config'
	    git clone https://git.coding.net/YGZ/oh-my-config.git ~/.oh-my-config
    fi
    if [ -d $tmux_config_path ]
    then 
        log_info 'update .tmux' 
        cd $tmux_config_path
        git pull
        cd $current_dir
    else 
        log_info 'download config'
	    git clone https://github.com/gpakosz/.tmux.git ~/.tmux
    fi
}
install_vim_config(){
    log_info 'install vim config'
    if [ ! -f $HOME/.vimrc  ]
    then
        ln -s $my_config_path/.vimrc ~
    else
        log_error "install vim config failed."$HOME/.vimrc" has existed"
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
}
install_tmux_config(){
    log_info 'install tmux config'
    if [ ! -f $HOME/.tmux.conf ] 
    then 
        ln -s $tmux_config_path/.tmux.conf $HOME
    else
        log_error "install .tmux failed."$HOME/.tmux.conf" has existed"
    fi
    if [ ! -f $HOME/.tmux.conf.local ] 
    then 
        cp $tmux_config_path/.tmux.conf.local $HOME
        echo "if '[ -f ~/.tmux.conf.local.self ]' 'source ~/.tmux.conf.local.self'" >> ~/.tmux.conf.local
    else
        log_error "install .tmux failed."$HOME/.tmux.conf.local" has existed"
    fi
    if [ ! -f $HOME/.tmux.conf.local.self ] 
    then 
        ln -s $my_config_path/.tmux.conf $HOME/.tmux.conf.local.self
    else
        log_error "install tmux config failed."$HOME/.tmux.conf.local.self" has existed"
    fi
    
}
install_shell_config(){
    log_info 'install shell config'
    if [ ! -f $HOME/.shrc ] 
    then 
        ln -s $my_config_path/.shrc $HOME
        echo "source ~/.shrc" >> ~/.`echo $SHELL | rev | cut -d'/' -f 1 | rev`rc
        . $HOME/.`echo $SHELL | rev | cut -d'/' -f 1 | rev`rc
    else
        log_error "install shrc config failed."$HOME/.shrc" has existed"
    fi
}
install_oh_my_zsh(){
    log_info 'install oh-my-zsh'
    if [ ! -d $zsh_config_path  ]
    then 
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    fi
}
check_git
case $1 in
    vim )
        download_config
        install_vim_config
        ;;
    tmux )
        download_config
        install_tmux_config 
        ;;
    shell )
        download_config
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
