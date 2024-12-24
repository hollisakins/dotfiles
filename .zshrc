export PATH="$PATH:/Library/TeX/texbin"
export XDG_CONFIG_HOME="$HOME/.config/"

eval "$(/opt/homebrew/bin/brew shellenv)"

export CW_USER="cosmosweb"
export CW_PSWD="0.6degsoon"

# If you come from bash you might have to change your $PATH.

autoload -U compinit && compinit

HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
setopt NO_BEEP

alias ls=lsd
alias lsl='lsd -l'
# FUNCTIONS
fdiff() {
	diff -u "$1" "$2" | diff-so-fancy
}

# zsh-z plugin
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.sh
ZSH_CASE=smart # lower case patterns are treated as case insensitive
zstyle ':completion:*' menu select # improve completion menu style

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


export DRIVE=$HOME/Dropbox/
export RESEARCH=$DRIVE/research/
export CODES=$HOME/codes/
export HOMEBREW_NO_ENV_HINTS="true"
# export PATH=$HOME/opt/homebrew/bin:$PATH
# export PATH=/Library/TeX/texbin:$PATH
# export PATH=$HOME/opt/miniforge3/bin:$PATH
export WEBBPSF_PATH=$CODES/webbpsf-data
export CRDS_PATH=$CODES/crds_cache/
export CRDS_SERVER_URL=https://jwst-crds.stsci.edu

export TERM="xterm-256color"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hollis/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hollis/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/hollis/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hollis/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/hollis/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/hollis/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

