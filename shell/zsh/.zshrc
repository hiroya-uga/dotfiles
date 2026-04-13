eval "$(~/.local/bin/mise activate zsh)"
export PATH="/usr/local/sbin:$PATH"

export GPG_TTY=$(tty)

gpg-auth() {
  gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
  echo "test" | gpg --clearsign -o /dev/null \
    && echo "✓ GPG authenticated" \
    || echo "✗ GPG auth failed"
}