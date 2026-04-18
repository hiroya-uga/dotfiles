param(
  [switch]$Force
)

Write-Host "🍣 Setting up dotfiles ..."

$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Definition

function Install-File($src, $dst, [switch]$Force) {
  $parent = Split-Path -Parent $dst
  if ($parent -and -not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }

  if (Test-Path -LiteralPath $dst) {
    if (-not $Force) {
      throw "Refusing to overwrite existing file: $dst`nRe-run with -Force to replace it."
    }

    Remove-Item -LiteralPath $dst -Force
  }

  Copy-Item -LiteralPath $src -Destination $dst
}


# PowerShell プロファイル（Zsh の .zshrc に相当）
Install-File "$CURRENT_DIR\shell\powershell\Microsoft.PowerShell_profile.ps1" $PROFILE -Force:$Force

# Git 設定
Install-File "$CURRENT_DIR\git\.gitconfig" "$HOME\.gitconfig" -Force:$Force
Install-File "$CURRENT_DIR\git\.gitignore_global" "$HOME\.gitignore_global" -Force:$Force

# EditorConfig
Install-File "$CURRENT_DIR\editor\.editorconfig" "$HOME\.editorconfig" -Force:$Force

# Prettier
Install-File "$CURRENT_DIR\editor\.prettierrc.js" "$HOME\.prettierrc.js" -Force:$Force

# Claude Code 設定
Install-File "$CURRENT_DIR\claude\settings.json" "$HOME\.claude\settings.json" -Force:$Force

# Claude Code スキル（外部リポジトリを git clone）
$SkillsDir = "$HOME\.claude\skills"
if (-not (Test-Path -LiteralPath $SkillsDir)) {
  New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
}

function Clone-Skill($repo, $name) {
  $dest = Join-Path $SkillsDir $name
  if (Test-Path -LiteralPath $dest) {
    Write-Host "Skill already exists, skipping: $dest"
  } else {
    git clone $repo $dest
  }
}

Clone-Skill "git@github.com:uga-skills/git-commit.git"    "git-commit"
Clone-Skill "git@github.com:uga-skills/review-markup.git" "review-markup"

Write-Host "✅ Dotfiles have been copied!"
Write-Host "   👉 Configure your Git identity in ~/.gitconfig.local:" -ForegroundColor Yellow
Write-Host "      git config -f ~/.gitconfig.local user.name       `"Your Name`""
Write-Host "      git config -f ~/.gitconfig.local user.email      `"you@example.com`""
Write-Host "      git config -f ~/.gitconfig.local user.signingkey `"YOUR_GPG_KEY_ID`""
Write-Host ""
