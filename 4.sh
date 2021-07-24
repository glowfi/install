#!/bin/fish

# PYTHON MODULES

pip install jupyter pandas matplotlib numpy scikit-learn openpyxl xlrd
pip install black virtualenv ranger-fm ueberzug

# JUPYTER SETUP

pip install notebook-as-pdf  jupyter_contrib_nbextensions jupyter_nbextensions_configurator
jupyter contrib nbextension install --user
jupyter nbextensions_configurator enable --user
pyppeteer-install

# DOWNLOAD NODEJS

wget https://nodejs.org/dist/v16.5.0/node-v16.4.1-linux-x64.tar.xz -O ~/node.tar.xz
tar -xf ~/node.tar.xz -C ~
rm -rf ~/node.tar.xz

# NODE MODULES

npm i -g npm@next
npm i -g yarn

# FZF TERMINAL INTEGRATION
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# INSTALL FETCHMASTER

pip install tcolorpy
mkdir -p ~/.local/bin
cp -r ~/install/fm ~/.local/bin/

echo "Enter Your Cpu name in short: "
read cpu_name
echo "Enter Your Gpu name in short: "
read gpu_name

sudo chmod +x ~/.local/bin/fm/fetchmaster.sh

echo "" >> ~/.local/bin/fm/fetchmaster.sh
echo "#CPU NAME" >> ~/.local/bin/fm/fetchmaster.sh
echo "echo '$cpu_name'" >> ~/.local/bin/fm/fetchmaster.sh

echo "" >> ~/.local/bin/fm/fetchmaster.sh
echo "#GPU NAME" >> ~/.local/bin/fm/fetchmaster.sh
echo "echo '$gpu_name'" >> ~/.local/bin/fm/fetchmaster.sh

# SETUP POSTGRES

sudo su - postgres -c "initdb --locale en_US.UTF-8 -D /var/lib/postgres/data;exit"
sudo su - postgres -c "(echo $USER;echo 'password';echo 'password';echo y;)|createuser --interactive -P;createdb -O $USER delta;exit"

# DOWNLOAD NEOVIM

pip install neovim pylint rope ueberzug
npm i -g neovim typescript typescript-language-server pyright vscode-langservers-extracted emmet-ls prettier eslint diagnostic-languageserver graphql-language-service-cli browser-sync
npx npm-check-updates -g
sudo pacman -S --noconfirm cmake unzip ninja tree-sitter xclip
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

# UNINSTALL NEOVIM

# sudo rm /usr/local/bin/nvim
# sudo rm -r /usr/local/share/nvim/

# CONFIGURING GIT ALIASES

git config --global user.name "-";git config --global user.email "-"
