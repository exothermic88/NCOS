if status is-interactive
    # Commands to run in interactive sessions can go here
end

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

alias btop='bpytop'

function sp
    set selected_file (fzf --preview 'bat --theme="Visual Studio Dark+" --color=always {}')
    
    if test -z "$selected_file"
        echo "No file selected"
        return
    end
    
    if string match -q "*.txt" $selected_file
        subl $selected_file
    else if string match -q "*.pdf" $selected_file
        evince $selected_file
    else if string match -q "*.py" $selected_file; or string match -q "*.cpp" $selected_file
        code $selected_file  # Open markdown and log files in Sublime as well
    else
        echo "Opening with default application..."
        xdg-open $selected_file
    end
end


function codep
     code $(fzf --preview 'bat --theme="Visual Studio Dark+" --color=always {}')
end
##################################################################
######################################

#TGPT FUNCTION

######################################

function gpt
     set user_input $argv
     set quoted_input "\"$user_input\""
     set temp_file (mktemp)

     # Run tgpt and capture the output
     tgpt $quoted_input | tee $temp_file

     # Detect language and extract code, regardless of language
     cat $temp_file | sed -n '/^```[a-zA-Z0-9]*$/,/^```$/ { /^```/! { p } }' | wl-copy

     # Clean up temporary file
     rm $temp_file
end

#regular gpt conversation
function gptm
  tgpt -m
end


function =
    set user_input $argv
    set quoted_input "\"$user_input\""
    tgpt -s $quoted_input
    #tgpt --provider openai --url "http://127.0.0.1:1234/v1/chat/completions" --model "qwen2.5-coder-1.5b-instruct" -s "$quoted_input"
end

#####################################################################

thefuck --alias | source

