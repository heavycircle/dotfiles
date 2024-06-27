sudo apt-get update -y && sudo apt-get full-upgrade -y
cd ~/Desktop

sudo apt-get install gcc g++ gdb gdbserver gcc-multilib g++-multilib -y
sudo apt-get autoremove -y && sudo apt-get cache clean
bash -c "$(curl -fsSL https://gef.blah.cat/sh)"

sudo apt-get install python3-pip
pip install pwn

sudo apt-get install eza xclip git tmux neovim
git clone https://github.com/thecae/dotfiles

mv ./dotfiles/.config/* ~/.config/
find ./dotfiles -maxdepth 1 -type f -exec mv {} ~/.config/ \;

mkdir ~/.local/share/fonts
mv ./dotfiles/fonts/* ~/.local/share/fonts
fc-cache -f -v
