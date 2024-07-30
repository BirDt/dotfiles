# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias neofetch='neofetch --ascii ~/.logo'
PS1='\[\e[33m\]\D{%H:%M - %d/%m/%y}\[\e[0m\] \[\e[97m\]|\[\e[0m\] \[\e[31m\]\u\[\e[35m\]@\[\e[91m\]\h\[\e[0m\] \[\e[97m\]|\[\e[0m\] \[\e[34m\]\w\n\[\e[31m\]$?\[\e[0m\] \[\e[91m\]\$\[\e[0m\] '
