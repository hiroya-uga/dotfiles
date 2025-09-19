#!/bin/zsh
set -eu

echo "🍣 Setting up dotfiles ..."

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

# バックアップしてコピーする関数
backup_and_copy() {
  local src=$1
  local dst=$2

  if [ -f "$dst" ]; then
    mv "$dst" "$dst.bak"
  fi

  cp "$src" "$dst"
}

# Zsh 設定
backup_and_copy "$CURRENT_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

# Git 設定
backup_and_copy "$CURRENT_DIR/git/.gitconfig" "$HOME/.gitconfig"
backup_and_copy "$CURRENT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
git config --global core.excludesfile "$HOME/.gitignore_global"

# EditorConfig
backup_and_copy "$CURRENT_DIR/editor/.editorconfig" "$HOME/.editorconfig"

# Prettier
backup_and_copy "$CURRENT_DIR/editor/.prettierrc.js" "$HOME/.prettierrc.js"

echo "✅ Dotfiles have been copied!"
echo "   👉 Don't forget to configure your Git identity:"
echo "      git config --global user.name  \"Your Name\""
echo "      git config --global user.email \"you@example.com\""
echo ""
