# zsh-z
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.sh
ZSH_CASE=smart

# powerlevel10k
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# autosuggestions (must be before syntax-highlighting)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax-highlighting (must be last plugin)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
