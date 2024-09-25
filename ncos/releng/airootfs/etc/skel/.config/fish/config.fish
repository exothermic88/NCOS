if status is-interactive
    # Commands to run in interactive sessions can go here
end

#fastfetch --logo /home/$USER/.config/fastfetch/fastfetch_logo -c paleofetch.jsonc
fastfetch

alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing
alias l.='eza -al --color=always --group-directories-first ../' # ls on the PARENT directory
alias l..='eza -al --color=always --group-directories-first ../../' # ls on directory 2 levels up
alias l...='eza -al --color=always --group-directories-first ../../../' # ls on directory 3 levels up

alias grep='grep --color=auto'

function sp
     subl $(fzf --preview 'bat --theme="Visual Studio Dark+" --color=always {}')
end

function codep
     code $(fzf --preview 'bat --theme="Visual Studio Dark+" --color=always {}')
end


function gpt
    set user_input $argv
    set quoted_input "\"$user_input\""
    tgpt $quoted_input
end

function gptm
     tgpt -m
end

starship init fish | source


thefuck --alias | source
