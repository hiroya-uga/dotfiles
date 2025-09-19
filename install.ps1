Write-Host "🍣 Setting up dotfiles ..."

$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

function Backup-And-Copy($src, $dst) {
  if (Test-Path $dst) {
    $bak = "$dst.bak"
    if (Test-Path $bak) { Remove-Item $bak -Force -ErrorAction SilentlyContinue }
    Rename-Item $dst $bak -Force
  }
  Copy-Item -Path $src -Destination $dst -Force
}


# PowerShell プロファイル（Zsh の .zshrc に相当）
Backup-And-Copy "$CURRENT_DIR\shell\powershell\Microsoft.PowerShell_profile.ps1" $PROFILE

# Git 設定
Backup-And-Copy "$CURRENT_DIR\git\.gitconfig" "$HOME\.gitconfig"
Backup-And-Copy "$CURRENT_DIR\git\.gitignore_global" "$HOME\.gitignore_global"
git config --global core.excludesfile "$HOME\.gitignore_global"

# EditorConfig
Backup-And-Copy "$CURRENT_DIR\editor\.editorconfig" "$HOME\.editorconfig"

# Prettier
Backup-And-Copy "$CURRENT_DIR\editor\.prettierrc.js" "$HOME\.prettierrc.js"

Write-Host "✅ Dotfiles have been copied!"
Write-Host "   👉 Don't forget to configure your Git identity:" -ForegroundColor Yellow
Write-Host "      git config --global user.name  \"Your Name\""
Write-Host "      git config --global user.email \"you@example.com\""
Write-Host ""
