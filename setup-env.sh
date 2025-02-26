#!/bin/bash

set -e  # Para interromper a execução em caso de erro

# Diretório de plugins do Zsh
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.zsh}
mkdir -p "$ZSH_CUSTOM"

# Instalação do zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/zsh-syntax-highlighting"

# Instalação do zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"

# Instalação do pyenv
if ! command -v pyenv &> /dev/null; then
    curl https://pyenv.run | bash
fi

# Adicionando ao ~/.zshrc
echo "# Configuração do zsh-syntax-highlighting" >> ~/.zshrc
echo "source \$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

echo "# Configuração do zsh-autosuggestions" >> ~/.zshrc
echo "source \$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# Configuração do pyenv no ~/.zshrc
echo "# Configuração do pyenv" >> ~/.zshrc
echo "export PATH=\"\$HOME/.pyenv/bin:\$PATH\"" >> ~/.zshrc
echo "eval \"\$(pyenv init --path)\"" >> ~/.zshrc
echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.zshrc

# Recarregar configurações do Zsh
source ~/.zshrc

echo "Instalação concluída!"

