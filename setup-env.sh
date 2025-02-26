#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Git configuration
GIT_NAME="Arthur Gehrke"
GIT_EMAIL="arthurgehrke07@gmail.com"
GIT_USER="arthurgehrke"
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global github.user "$GIT_USER"

# Ensure Python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Installing Python3..."
    sudo apt update && sudo apt install -y python3
else
    echo "Python3 is already installed. Skipping."
fi

# Install Tor and Proxychains
if ! command -v tor &> /dev/null; then
    echo "Installing Tor..."
    sudo apt install -y tor
else
    echo "Tor is already installed. Skipping."
fi

if ! command -v proxychains &> /dev/null; then
    echo "Installing Proxychains..."
    sudo apt install -y proxychains
else
    echo "Proxychains is already installed. Skipping."
fi

# Install Anonsurf
if [ ! -d "$HOME/kali-anonsurf" ]; then
    echo "Installing Anonsurf..."
    git clone https://github.com/Und3rf10w/kali-anonsurf.git "$HOME/kali-anonsurf"
    cd "$HOME/kali-anonsurf" && sudo ./installer.sh && cd ..
    rm -rf "$HOME/kali-anonsurf"
else
    echo "Anonsurf is already installed. Skipping."
fi

# Remove conflicting profile files
for file in "$HOME/.profile" "$HOME/.bash_profile" "$HOME/.zprofile"; do
    if [ -f "$file" ]; then
        echo "Removing existing file: $file"
        rm "$file"
    fi
done

# Zsh plugins directory
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.zsh}
mkdir -p "$ZSH_CUSTOM"

# Install zsh-syntax-highlighting if not already installed
if [ ! -d "$ZSH_CUSTOM/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting is already installed. Skipping."
fi

# Install zsh-autosuggestions if not already installed
if [ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"
else
    echo "zsh-autosuggestions is already installed. Skipping."
fi

# Install pyenv if not already installed
if [ -d "$HOME/.pyenv" ]; then
    echo "WARNING: pyenv is already installed. Please remove the '$HOME/.pyenv' directory first."
    exit 1
else
    curl https://pyenv.run | bash
fi

# Add configurations to ~/.zshrc if not already present
if ! grep -q "export PATH=\"\$HOME/.pyenv/bin:\$PATH\"" ~/.zshrc; then
    echo "# pyenv configuration" >> ~/.zshrc
    echo "export PATH=\"\$HOME/.pyenv/bin:\$PATH\"" >> ~/.zshrc
    echo "eval \"\$(pyenv init --path)\"" >> ~/.zshrc
    echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.zshrc
else
    echo "pyenv configuration already exists in ~/.zshrc. Skipping."
fi

# Add plugin sources to ~/.zshrc if not already present
if ! grep -q "source \$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ~/.zshrc; then
    echo "# zsh-syntax-highlighting configuration" >> ~/.zshrc
    echo "source \$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

if ! grep -q "source \$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh" ~/.zshrc; then
    echo "# zsh-autosuggestions configuration" >> ~/.zshrc
    echo "source \$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
fi

# Reload Zsh configuration
source ~/.zshrc

echo "Installation completed!"

