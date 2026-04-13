# Vim and Tmux configuration

## Prerequisites
 - Install [powerline fonts](https://github.com/powerline/fonts?tab=readme-ov-file#installation)
 - Configure your terminal to use the installed font
 ```bash
 # get default profile and remove single quotation
 profile=$(gsettings get org.gnome.Terminal.ProfilesList default |  sed "s/'//g")

 # dump current config
 dconf dump /org/gnome/terminal/legacy/profiles:/:$profile/ > current.backup

 # update to Hack Nerd Font
 dconf write /org/gnome/terminal/legacy/profiles:/:$profile/font "'Hack Nerd Font Mono 12'"

 # backup if needed by
 dconf load /org/gnome/terminal/legacy/profiles:/:$profile/ < current.backup
 ```

## Tmux
1. Use tmux 3.5 but <3.6 (older versions may not work correctly)
2. Compile tmux from sources
```bash
apt install -y libevent-dev libncurses-dev bison
curl -s https://api.github.com/repos/tmux/tmux/releases | grep 'download_url.*3\.5a\.tar' | grep -o 'http.*gz' | xargs wget
tar -xvf *.tar.gz
cd *.tar.gz
./configure --enable-static
make
ldd tmux
```
3. Copy [confs/.tmux.conf](../confs/.tmux.conf) into `${HOME}/.tmux.conf`
4. Run tmux and install plugins with `Prefix + I`


## Vim
1. Copy [confs/.vimrc](../confs/.vimrc) into `${HOME}/.vimrc`
2. Install vim-plug: `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
3. Run `:PlugInstall` in vim to install plugins
