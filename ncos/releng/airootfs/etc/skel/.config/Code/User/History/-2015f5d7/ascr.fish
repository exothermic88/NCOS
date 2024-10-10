if status is-interactive
    # Commands to run in interactive sessions can go here
end

#fastfetch --logo /home/$USER/.config/fastfetch/fastfetch_logo -c paleofetch.jsonc
fastfetch

starship init fish | source   

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
##################################################################
######################################

#TGPT FUNCTION

######################################
#regular gpt 
function gpt
    set user_input $argv
    set quoted_input "\"$user_input\""
    tgpt $quoted_input
end

#python copy
function pgpt
set user_input $argv
    set quoted_input "\"$user_input\""
    set temp_file (mktemp); tgpt $quoted_input | tee $temp_file; cat $temp_file | sed -n '/^```python$/,/^```$/ { /^```/! { /^```python$/! p } }' | xclip -selection clipboard; rm $temp_file
end

#java copy
function jgpt
set user_input $argv
    set quoted_input "\"$user_input\""
    set temp_file (mktemp); tgpt $quoted_input | tee $temp_file; cat $temp_file | sed -n '/^```java$/,/^```$/ { /^```/! { /^```java$/! p } }' | xclip -selection clipboard; rm $temp_file
end

#c copy
function cgpt
set user_input $argv
    set quoted_input "\"$user_input\""
    set temp_file (mktemp); tgpt $quoted_input | tee $temp_file; cat $temp_file | sed -n '/^```c$/,/^```$/ { /^```/! { /^```c$/! p } }' | xclip -selection clipboard; rm $temp_file
end

#cpp copy
function cpgpt
set user_input $argv
    set quoted_input "\"$user_input\""
    set temp_file (mktemp); tgpt $quoted_input | tee $temp_file; cat $temp_file | sed -n '/^```cpp$/,/^```$/ { /^```/! { /^```cpp$/! p } }' | xclip -selection clipboard; rm $temp_file
end

#regular gpt conversation
function gptm
     tgpt -m
end

#python copy conversation
function pai
    set temp_file (mktemp); tgpt -m | tee $temp_file; cat $temp_file | sed -n '/^```python$/,/^```$/ { /^```/! { /^```python$/! p } }' | xclip -selection clipboard; rm $temp_file
end
#####################################################################

thefuck --alias | source
