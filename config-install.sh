#! /bin/bash
check_git(){
	if command -v git >/dev/null 2>&1; then 
		echo 'exists git' 
		return 1
	else 
	    echo 'no exists git' 
        exit -1
	fi
}
download_config(){
    echo 'downloading..'
	git clone https://git.coding.net/YGZ/oh-my-config.git ~
	git clone https://github.com/gpakosz/.tmux.git ~
}
install_vim_config(){
	git clone https://git.coding.net/YGZ/oh-my-config.git ~
    ln -s ~/oh-my-config/.vimrc ~
}
install_tmux_config(){
	download_config
    ln -s -f ~/.tmux/.tmux.conf
    cp ~/.tmux/.tmux.conf.local ~
    ln -s ~/oh-my-config/.tmux.conf ~/.tmux.conf.locale.self
    echo "if '[ -f ~/.tmux.conf.local.self ]' 'source ~/.tmux.conf.local.self'" >> ~/.tmux.conf.local
}
install_shell_config(){
	git clone https://git.coding.net/YGZ/oh-my-config.git ~
    ln -s ~/oh-my-config/.shrc ~
    echo "source ~/.shrc" >> ~/.`echo $SHELL | rev | cut -d'/' -f 1 | rev`rc
}
check_git
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
    *)
        install_vim_config 
        install_tmux_config 
        install_shell_config
esac
