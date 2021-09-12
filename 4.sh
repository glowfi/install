#!/bin/fish

# PYTHON MODULES

pip install jupyter pandas matplotlib numpy scikit-learn openpyxl xlrd
pip install virtualenv

# JUPYTER SETUP

pip install notebook-as-pdf  jupyter_contrib_nbextensions jupyter_nbextensions_configurator
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
pyppeteer-install

# DOWNLOAD NODEJS

wget https://nodejs.org/dist/v16.9.0/node-v16.9.0-linux-x64.tar.xz -O ~/node.tar.xz
tar -xf ~/node.tar.xz -C ~
rm -rf ~/node.tar.xz

# NODE MODULES

npm i -g npm@next
npm i -g yarn


# FZF TERMINAL INTEGRATION

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# INSTALL CHECKUR

pip install rich
cp -r ~/install/scripts/checkur.py ~/.local/bin/
chmod +x ~/.local/bin/checkur.py

# SETUP POSTGRES

sudo su - postgres -c "initdb --locale en_US.UTF-8 -D /var/lib/postgres/data;exit"
sudo systemctl start postgresql
sudo su - postgres -c "(echo $USER;echo 'password';echo 'password';echo y;)|createuser --interactive -P;createdb -O $USER delta;exit"

# DOWNLOAD NEOVIM

pip install neovim ueberzug black
npm i -g neovim typescript typescript-language-server pyright vscode-langservers-extracted emmet-ls prettier @fsouza/prettierd eslint eslint_d diagnostic-languageserver graphql-language-service-cli browser-sync
npx npm-check-updates -g
sudo pacman -S --noconfirm cmake unzip ninja tree-sitter xclip fortune-mod
git clone https://github.com/neovim/neovim --depth 1
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ..
sudo rm -r neovim


# COPY NEOVIM SETTINGS

cp -r ~/install/nvim ~/.config
nvim -c "PackerSync"
nvim -c "PackerSync"
nvim -c "PackerSync"
echo "done"


# CONFIGURING GIT ALIASES

git config --global user.name "-";git config --global user.email "-"
