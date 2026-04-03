#!/bin/bash
# A script for bootstrapping a fresh installation.
set -euo pipefail
cd
echo "Installing some packages"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt install \
    rlwrap ripgrep tmux xsel \
    powerline kitty neovim \
    python3-dev python3-pip gparted \
    cryptsetup lvm2 \
    npm
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

mkdir -p git
pushd git
git clone https://github.com/gpakosz/.tmux
popd

echo "Setting up shell customizations"
ln -sf ~/git/.tmux/.tmux.conf
ln -sf ~/git/dotfiles-gh/.tmux.conf.local
ln -sf ~/git/dotfiles-gh/.profile.local
echo ". ~/.profile.local" >> .profile
ln -sf ~/git/dotfiles-gh/.bashrc.local
echo ". ~/.bashrc.local" >> .bashrc
mkdir -p .config
cd .config
if [ -d nvim ]; then
    mv -f nvim nvim.old
fi
ln -sf ~/git/dotfiles-gh/nvim 
if [ -d kitty ]; then
    mv -f kitty kitty.old
fi
cd

mkdir -p node_modules
npm install --prefix ~/ tree-sitter-cli
ln -sf node_modules/.bin/tree-sitter .local/bin/

