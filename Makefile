SHELL=/bin/bash
HOMEDIR=${HOME}
PATH_VAR=${PATH}
THINGS_TO_LINK=.zshrc .tmux.conf 

UNAME := $(shell uname)

all: install

link:
	@echo "creating symlinks for [.tmux.conf, .zshrc, .aliases.sh]"
	ln -f -s ${PWD}/tmux/.tmux.conf $(HOMEDIR)/.tmux.conf
	ln -f -s ${PWD}/linux/.aliases.sh $(HOMEDIR)/.aliases.sh
	mkdir -p $(HOMEDIR)/bin
	ln -f -s ${PWD}/scripts/touchr $(HOMEDIR)/bin/touchr

install: install-packages

init-bin:
	mkdir -p $(HOMEDIR)/bin
	export PATH=$(PATH_VAR):$(HOMEDIR)/bin

install-packages:
ifeq ($(UNAME),Darwin)
	@echo "Darwin detected"
	brew install \
		vim \
		git \
		curl \
		wget \
		coreutils \
		powerline \
		neovim \
		httpie 
else
	@echo "Linux detected. Assuming there's an apt binary."	
	sudo apt-get update -y
	sudo apt install -y \
		git \
		curl \
		tree \
		powerline \
		neovim \
      mercurial \
		binutils \
		bison \
		gcc  \
		build-essential \
		httpie \
		software-properties-common \
		fd-find \
		lua5.3 \
		inxi \
		net-tools \
		jq \
		bat \
		imagemagick \
		apt-transport-https

 
	
endif

# fd
fd:
	@echo "installing fd command"
	wget https://github.com/sharkdp/fd/releases/download/v8.6.0/fd-musl_8.6.0_amd64.deb   
	sudo dpkg -i fd-musl_8.6.0_amd64.deb  
	rm fd-musl_8.6.0_amd64.deb

# zsh stuff
zsh:
	@echo "creating symlink to .zshrc"
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	@echo "installing zsh"
	sudo apt-get install -y zsh

oh-my-zsh:
	@echo "installing oh-my-zsh"
	wget -O install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	sh install.sh
	@echo "rm installed script"
	rm install.sh
	@echo "rm .zshrc.pre-oh-my-zsh created by oh-my-zsh"
	rm $(HOMEDIR)/.zshrc.pre-oh-my-zsh
	@echo "creating links again"
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	@echo "creating powerlevel10k"
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc
	@echo "starting zsh"
	chsh -s /usr/bin/zsh


oh-my-zsh-plugins:
	git clone https://github.com/zsh-users/zsh-autosuggestions $(HOMEDIR)/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOMEDIR)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


powerlevel10k:
	@echo "creating symlink to .p10k.zsh"
	ln -f -s ${PWD}/linux/.p10k.zsh $(HOMEDIR)/.p10k.zsh
	@echo "installing powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $(HOMEDIR)/.oh-my-zsh/custom/themes/powerlevel10k
	@echo "resource ~/.zshrc in order for the changes to take effect"

zsh-final:
	ln -f -s ${PWD}/linux/.zshrc $(HOMEDIR)/.zshrc

# end zsh stuff

nvim:
	echo "setting up neovim repo from https://github.com/magdyamr542/nvim"
	mkdir -p $(HOMEDIR)/.config/
	git clone https://github.com/magdyamr542/nvim $(HOMEDIR)/.config/nvim
	curl -LO https://github.com/neovim/neovim/releases/download/v0.7.0/nvim.appimage
	chmod u+x nvim.appimage
	mv ./nvim.appimage  $(HOMEDIR)/bin/nvim
	nvim --headless +PlugInstall +qall

nodejs:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	nvm install --lts

autojump:
	git clone git@github.com:wting/autojump.git
	cd autojump && ./install.py && cd .. && rm -rf autojump

pyenv:
	curl https://pyenv.run | bash

golang:
	bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
	source ~/.gvm/scripts/gvm
	# install go1.4 that uses a c compiler to be able to install go versions that use a go compiler
	gvm install go1.4 -B
	gvm use go1.4
	export GOROOT_BOOTSTRAP=$GOROOT
	gvm install go1.19
	gvm use go1.19
	ln -s $(HOMEDIR)/.gvm/gos/go1.19/ ~/go

# tmux stuff
setup-tmux:
	@echo Add the command gnome-terminal -e 'tmux new' as a keyboard shortcut
	
install-tmux:
	@echo "installing tmux"
	./tmux/install.sh
	$(MAKE) install-tmux-plugin-manager

install-tmux-plugin-manager:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	tmux source ~/.tmux.conf
	@echo "Use <ctrl-b>I to install the tmux plugins"
# end tmux stuff

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

sdk-man:
	 curl -s "https://get.sdkman.io" | bash
	 source "$(HOME)/.sdkman/bin/sdkman-init.sh"

chrome:
	 wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	 sudo apt install ./google-chrome-stable_current_amd64.deb
	 rm ./google-chrome-stable_current_amd64.deb

manual-install:
	@echo "Don't forget to manually install these"
	@echo "Project root -> https://github.com/magdyamr542/project-root"
	@echo "Docker -> https://github.com/docker/docker-install"
	@echo "Java after installing sdkman"
	@echo "Sync vscode settings"

vscode:
	 wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	 sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	 sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	 sudo apt update
	 sudo apt install code
	 rm packages.microsoft.gpg

backup-installed-commands:
	dpkg --clear-selections
	sudo apt install < ./linux/installed-commands

aws-cli:
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	./aws/install -i /usr/local/aws-cli -b /usr/local/bin
	sudo rm -rf aws awscliv2.zip

ngrok:
	curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok

ansible:
	sudo apt-add-repository ppa:ansible/ansible
	sudo apt update
	sudo apt install -y ansible

virtualbox:
	sudo apt-get install virtualbox

screen-recorder:
	sudo add-apt-repository ppa:atareao/atareao
	sudo apt install screenkeyfk


.PHONY: nvim zsh install install-packages link all autojump

