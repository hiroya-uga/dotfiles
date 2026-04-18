# dotfiles

Personal dotfiles for macOS + Windows (PowerShell).  
Used as a **submodule** in <https://github.com/hiroya-uga/setup>.

Links:

- Git configuration (`.gitconfig`, `.gitignore_global`)
- EditorConfig (`.editorconfig`)
- Prettier configuration (`.prettierrc`)
- Claude Code (`settings.json`, skills via git clone)
- macOS:
  - Zsh configuration (`.zshrc`)
- Windows:
  - PowerShell profile (`Microsoft.PowerShell_profile.ps1`)

## Setup

### macOS

```sh
zsh ./install.sh --symlink
```

Use `--force` to replace existing files.

### Windows (PowerShell)

```pwsh
./install.ps1
```

Use `-Force` to replace existing files.

## Git Identity

Store machine-specific Git settings in `~/.gitconfig.local`.

```sh
git config -f ~/.gitconfig.local user.name       "Your Name"
git config -f ~/.gitconfig.local user.email      "you@example.com"
git config -f ~/.gitconfig.local user.signingkey "YOUR_GPG_KEY_ID"
```
