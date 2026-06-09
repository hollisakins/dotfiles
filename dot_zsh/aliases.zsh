# SSH hosts
alias tacc='ssh ls6.tacc.utexas.edu'
alias candide='ping -c 1 -s 999 candide.iap.fr; ssh -X hakins@candide.iap.fr'
alias hpg='ssh hollis.akins@hpg2.rc.ufl.edu'

# Applications
alias casa=/Applications/CASA.app/Contents/MacOS/casa
alias eazy=$CODES/eazy-photoz/src/eazy
alias imfit=$CODES/imfit-1.9.0/imfit
alias agnfitter=$CODES/AGNfitter/RUN_AGNfitter_multi.py
alias idl=/Applications/exelis/idl/bin/idl
alias galfit=~/codes/galfit
alias apt="/Applications/APT\ 2026.3.1/bin/apt"

# Overrides
alias vim=nvim
alias ls=lsd
alias lsl="lsd -l"

# Utilities
alias disk='duf / /Volumes/maurice /Volumes/simmons'

alias stop-globalprotect="launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"
alias start-globalprotect="launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*"