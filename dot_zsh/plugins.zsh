# Plugins come from Homebrew on macOS, or from ~/.zsh/plugins (cloned via
# .chezmoiexternal.toml) elsewhere. Missing plugins are skipped.
_zsh_plugin() {
  local f
  for f in "$@"; do
    [[ -f $f ]] && { source "$f"; return }
  done
}

# zsh-z
_zsh_plugin ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh ~/.zsh/plugins/zsh-z/zsh-z.plugin.sh
ZSH_CASE=smart

# powerlevel10k
_zsh_plugin /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme \
  ~/.zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# autosuggestions (must be before syntax-highlighting)
_zsh_plugin /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax-highlighting (must be last plugin)
_zsh_plugin /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

unfunction _zsh_plugin
