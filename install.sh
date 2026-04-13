#!/bin/zsh
set -eu

echo "🍣 Setting up dotfiles ..."

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 引数で動作を制御（デフォルト copy、--symlink でシンボリックリンク）
USE_SYMLINK=false
for arg in "$@"; do
  case "$arg" in
    --symlink) USE_SYMLINK=true ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

# シンボリックリンク or コピーする関数（実ファイルが存在する場合はバックアップ）
backup_and_link() {
  local src=$1
  local dst=$2

  if [ -f "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak"
  fi

  if [[ "$USE_SYMLINK" == "true" ]]; then
    ln -sf "$src" "$dst"
  else
    cp "$src" "$dst"
  fi
}

# Zsh 設定
backup_and_link "$CURRENT_DIR/shell/zsh/.zshrc" "$HOME/.zshrc"

# Git 設定
backup_and_link "$CURRENT_DIR/git/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$CURRENT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"

# EditorConfig
backup_and_link "$CURRENT_DIR/editor/.editorconfig" "$HOME/.editorconfig"

# Prettier
backup_and_link "$CURRENT_DIR/editor/.prettierrc.js" "$HOME/.prettierrc.js"

if [[ "$USE_SYMLINK" == "true" ]]; then
  echo "✅ Dotfiles have been linked!"
else
  echo "✅ Dotfiles have been copied!"
fi
echo "   👉 Configure your Git identity in ~/.gitconfig.local:"
echo "      git config -f ~/.gitconfig.local user.name       \"Your Name\""
echo "      git config -f ~/.gitconfig.local user.email      \"you@example.com\""
echo "      git config -f ~/.gitconfig.local user.signingkey \"YOUR_GPG_KEY_ID\""
echo ""
