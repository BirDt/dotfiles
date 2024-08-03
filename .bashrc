# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias neofetch='neofetch --ascii ~/.logo'
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)';
PS1='\[\e[33m\]\D{%H:%M - %d/%m/%y}\[\e[0m\] \[\e[97m\]|\[\e[0m\] \[\e[31m\]\u\[\e[35m\]@\[\e[91m\]\h\[\e[0m\] \[\e[97m\]|\[\e[0m\] \[\e[34m\]\w \[\e[97m\]|\[\e[0m\] \[\e[95m\]${PS1_CMD1}\[\e[0m\]\n\[\e[31m\]$?\[\e[0m\] \[\e[91m\]\$\[\e[0m\] '
