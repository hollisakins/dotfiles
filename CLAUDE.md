# dotfiles

## Overview
Managed with chezmoi. Secrets injected via 1Password CLI at apply-time — never stored in the repo.

chezmoi source dir: `/Users/hba423/codes/dotfiles` (set in `~/.config/chezmoi/chezmoi.toml`)

## Structure
Chezmoi naming conventions: `dot_` prefix → `.` in target, `.tmpl` suffix → processed as Go template, `private_` prefix → 0600 permissions.

### Shell (zsh)
- `dot_zshrc.tmpl` → `~/.zshrc` — thin loader: p10k instant prompt, history config, sources modules
- `dot_zsh/` → `~/.zsh/` — modular zsh config:
  - `exports.zsh.tmpl` — PATH, env vars, 1Password secrets
  - `aliases.zsh` — shell aliases
  - `functions.zsh` — shell functions
  - `completions.zsh` — compinit and completion styles
  - `plugins.zsh` — p10k, zsh-z, autosuggestions, syntax-highlighting
  - `conda.zsh` — conda init and base activation
  - `beagle.zsh` — BEAGLE environment variables
- `dot_zprofile` → `~/.zprofile` — homebrew shellenv
- `dot_p10k.zsh` → `~/.p10k.zsh` — powerlevel10k prompt config

### Git
- `dot_gitconfig` → `~/.gitconfig` — user identity, push config, credential helpers

### Apps (`dot_config/` → `~/.config/`)
- `ghostty/config` — terminal: Catppuccin theme, Monaspace font, transparency, keybinds
- `nvim/` — neovim: lazy.nvim plugin manager, nightfox theme, neo-tree, lualine, which-key
- `gh/private_config.yml` — GitHub CLI settings (hosts.yml excluded — contains OAuth token)
- `lsd/config.yaml` — lsd file listing config

## Secrets
- All secrets stored in 1Password vault "zsh", injected via `{{ onepasswordRead "op://zsh/..." }}` in `.tmpl` files
- Never hardcode secrets or API keys anywhere in this repo
- `gh/hosts.yml` is NOT managed — contains OAuth tokens

## Conventions
- New aliases go in `dot_zsh/aliases.zsh` with a comment explaining the command
- New functions go in `dot_zsh/functions.zsh`
- New env vars / PATH entries go in `dot_zsh/exports.zsh.tmpl`
- New secrets go in 1Password first, then referenced via chezmoi template
- Test changes with `chezmoi diff` before `chezmoi apply`
