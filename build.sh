#!/bin/sh

get_installer() {
    curl -s https://api.github.com/repos/$1/releases/latest \
    | grep "browser_download_url.*deb" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -qi -
}

sudo apt-get update -y
sudo apt-get full-upgrade -y

# -- Essentials
sudo apt install zsh tmux neovim git -y

# -- Configuration files
git clone https://github.com/coleellis/lazytown.nvim.git ~/.config/nvim
git clone https://github.com/coleellis/dotfiles.git ~/Desktop/dotfiles

# -- ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
cp ~/Desktop/dotfiles/.zshrc ~/.zshrc
cp ~/Desktop/dotfiles/.zsh_aliases ~/.zsh_aliases

# -- Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# -- EZA
sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# -- Utilities
curl -sS https://starship.rs/install.sh | sh
curl https://sh.rustup.rs -sSf | sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.zshrc

# -- C/C++
sudo apt install clang-format clangd gcc g++ gdb cmake make
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"
cp ~/Desktop/dotfiles/.clang-format ~/.clang-format
cp ~/Desktop/dotfiles/cmakebuild /usr/local/bin/cmakebuild

# -- Python
sudo apt install python3-pip

# -- Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo groupadd docker
sudo usermod -aG docker $USER

# -- Random other things I like
sudo apt install net-tools tree wireshark

# -- Programs
get_installer "obsidianmd/obsidian-releases"
get_installer "NationalSecurityAgency/ghidra"
