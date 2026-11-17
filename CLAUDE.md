# dotfiles

## Overview
Managed with chezmoi. Secrets injected via 1Password CLI at apply-time — never stored in the repo.

chezmoi source dir: set via `~/.config/chezmoi/chezmoi.toml` (machine-specific)

Used on two kinds of machine:
- **macOS laptop** — full config, including 1Password secrets, Homebrew, apps
- **Linux clusters** (e.g. Princeton della) — shell, git, nvim, matplotlib, Claude statusline; no secrets, no Homebrew

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
  - `conda.zsh.tmpl` — conda init and base activation (macOS only)
  - `beagle.zsh` — BEAGLE environment variables
  - `local.zsh` — NOT managed; per-machine overrides and secrets, sourced last if present
- `dot_zprofile` → `~/.zprofile` — homebrew shellenv (skipped if brew is absent)
- `.chezmoiexternal.toml.tmpl` — clones zsh-z into `~/.zsh/plugins/` on every OS (no Homebrew formula exists); on Linux also clones p10k, autosuggestions, syntax-highlighting (macOS gets those from Homebrew)
- `dot_p10k.zsh` → `~/.p10k.zsh` — powerlevel10k prompt config

### Git
- `dot_gitconfig.tmpl` → `~/.gitconfig` — user identity, push config, gh credential helpers (macOS only)
- `dot_config/git/ignore` → `~/.config/git/ignore` — global gitignore

### SSH
- `dot_ssh/private_config` → `~/.ssh/config` — host aliases and identity file references
- Private keys live in 1Password (vault "zsh") and are served by the 1Password SSH agent; they are never on disk
  - Hosts using them set `IdentityAgent` to the 1Password socket and `IdentityFile` to the key's `.pub` (managed in `dot_ssh/`)
  - `dot_config/private_1Password/ssh/agent.toml` lets the agent serve the "zsh" vault (default is Private only)
  - Per machine: enable 1Password → Settings → Developer → "Use the SSH agent"
- Hosts whose keys aren't in 1Password yet (e.g. ls6) still expect the private key file in `~/.ssh/`

### Apps (`dot_config/` → `~/.config/`)
- `ghostty/config` — terminal: Catppuccin theme, Monaspace font, transparency, keybinds
- `nvim/` — neovim: lazy.nvim plugin manager, nightfox theme, neo-tree, lualine, which-key
- `gh/private_config.yml` — GitHub CLI settings (hosts.yml excluded — contains OAuth token)
- `lsd/config.yaml` — lsd file listing config

### Claude Code
- `dot_claude/executable_statusline-command.sh` → `~/.claude/statusline-command.sh` — Catppuccin status line (needs `jq`)
- `~/.claude/settings.json` is NOT managed — Claude Code rewrites it. Point it at the script once per machine:
  `"statusLine": {"type": "command", "command": "bash ~/.claude/statusline-command.sh"}`

### VS Code
- `private_Library/.../Code/User/settings.json` — editor settings, Python config, copilot prefs
- `private_Library/.../Code/User/keybindings.json` — custom keybindings

### Homebrew
- `Brewfile` — all brew/cask/vscode-extension packages (`brew bundle install` to restore)

## Secrets
- All secrets stored in 1Password vault "zsh", injected via `{{ onepasswordRead "op://zsh/..." }}` in `.tmpl` files
- Never hardcode secrets or API keys anywhere in this repo
- `gh/hosts.yml` is NOT managed — contains OAuth tokens
- SSH private keys are NOT stored in the repo — they live in 1Password

## Multi-machine (macOS vs Linux)
- OS-specific content is gated with `{{ if eq .chezmoi.os "darwin" }}` in `.tmpl` files
- macOS-only files (Brewfile, Library/, ghostty, ssh config) are excluded on Linux in `.chezmoiignore`
- Optional chezmoi data (`[data]` in `chezmoi.toml`): `campfireRoot` — sets `CAMPFIRE_ROOT`/`CRDS_PATH` if present
- Plain `.zsh` files that run everywhere should guard tool-specific bits, e.g. `(( $+commands[lsd] )) && alias ls=lsd`

### Bootstrapping a cluster (della)
```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init hollisakins/dotfiles
~/.local/bin/chezmoi diff     # review
~/.local/bin/chezmoi apply
```
Then:
- Make zsh the interactive shell: add `[[ $- == *i* ]] && command -v zsh >/dev/null && exec zsh` to the end of `~/.bashrc` (cluster login shell stays bash)
- Put cluster-specific setup (e.g. `module load anaconda3/<version>`) and any needed secrets in `~/.zsh/local.zsh` (`chmod 600`)
- Add the `statusLine` entry to `~/.claude/settings.json` (see above)
- Update later with `chezmoi update`

## Conventions
- New aliases go in `dot_zsh/aliases.zsh` with a comment explaining the command
- New functions go in `dot_zsh/functions.zsh`
- New env vars / PATH entries go in `dot_zsh/exports.zsh.tmpl`
- New secrets go in 1Password first, then referenced via chezmoi template
- Test changes with `chezmoi diff` before `chezmoi apply`
