export PATH="/usr/local/sbin:$PATH"

if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

export GPG_TTY=$(tty)

gpg-auth() {
  gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
  echo "test" | gpg --clearsign -o /dev/null \
    && echo "✓ GPG authenticated" \
    || echo "✗ GPG auth failed"
}