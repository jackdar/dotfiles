# Clear terminal
function clear-terminal() {
  tput reset;
  zle redisplay;
}
zle -N clear-terminal
bindkey '^l' clear-terminal

  # Get ticket number from branch name and paste into shell buffer
function paste_ticket_number() {
  function get_ticket_number() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    
    if [[ "$branch" != "main" && "$branch" != "master" && "$branch" != "development" ]]; then
      if [[ "$branch" =~ (HBT-[0-9]{1,4}) ]]; then
        echo "${match[1]}"
      else
        echo "$branch"
      fi
    fi
  }

  LBUFFER+="$(get_ticket_number)"
  zle -R
}
zle -N paste_ticket_number
bindkey '^b' paste_ticket_number
