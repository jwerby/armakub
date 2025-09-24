#!/bin/bash

if ! declare -F omakub_return >/dev/null 2>&1; then
  omakub_return() { return 0 2>/dev/null || exit 0; }
fi

case "$OMAKUB_ARCH" in
  x86_64)
    NVIM_PACKAGE="nvim-linux-x86_64"
    ;;
  aarch64)
    NVIM_PACKAGE="nvim-linux-arm64"
    ;;
  *)
    echo "Skipping Neovim binary install: no release available for architecture $OMAKUB_ARCH"
    omakub_return
    return
    ;;
esac

cd /tmp
wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/${NVIM_PACKAGE}.tar.gz"
tar -xf nvim.tar.gz
sudo install ${NVIM_PACKAGE}/bin/nvim /usr/local/bin/nvim
sudo cp -R ${NVIM_PACKAGE}/lib /usr/local/
sudo cp -R ${NVIM_PACKAGE}/share /usr/local/
rm -rf ${NVIM_PACKAGE} nvim.tar.gz
cd -

# Install luarocks and tree-sitter-cli to resolve lazyvim :checkhealth warnings
sudo apt install -y luarocks tree-sitter-cli

# Only attempt to set configuration if Neovim has never been run
if [ ! -d "$HOME/.config/nvim" ]; then
  # Use LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  # Remove the .git folder, so you can add it to your own repo later
  rm -rf ~/.config/nvim/.git

  # Make everything match the terminal transparency
  mkdir -p ~/.config/nvim/plugin/after
  cp ~/.local/share/omakub/configs/neovim/transparency.lua ~/.config/nvim/plugin/after/

  # Default to Tokyo Night theme
  cp ~/.local/share/omakub/themes/tokyo-night/neovim.lua ~/.config/nvim/lua/plugins/theme.lua

  # Turn off animated scrolling
  cp ~/.local/share/omakub/configs/neovim/snacks-animated-scrolling-off.lua ~/.config/nvim/lua/plugins/

  # Turn off relative line numbers
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua

  # Ensure editor.neo-tree is used by default
  cp ~/.local/share/omakub/configs/neovim/lazyvim.json ~/.config/nvim/
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
  sudo rm -rf /usr/share/applications/nvim.desktop
  sudo rm -rf /usr/local/share/applications/nvim.desktop
  source ~/.local/share/omakub/applications/Neovim.sh
fi
