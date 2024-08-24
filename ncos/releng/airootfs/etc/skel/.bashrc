#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

exec fish

alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
