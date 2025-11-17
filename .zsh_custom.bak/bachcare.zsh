# -- [[ Bachcare ZSH ]] --
export DOTFILES_ENV="bachcare"
# Bachcare work scripts (work only)
export PATH="$HOME/.local/bachcare/:$PATH"

# AWS SSO and SAM variables
export AWS_DEFAULT_PROFILE="staging"
export AWS_PROFILE="staging"
export AWS_DEFAULT_REGION="ap-southeast-2"
export AWS_REGION="ap-southeast-2"

# -- [[ Widgets ]] --
# Pasting ticket number widget
function paste-ticket-number() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
          zle -R
        else
    local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

    if [[ "$branch" != "main" && "$branch" != "master" && "$branch" != "development" ]]; then
      if [[ "$branch" =~ (HBT-[0-9]{1,4}) ]]; then
        LBUFFER+="${match[1]}"
      else
        LBUFFER+="$branch"
      fi
    fi
  fi
}
zle -N paste-ticket-number

# AWS SSO login widget
function aws-sso-login() {
  BUFFER="aws sso login --profile staging"
  zle accept-line
}
zle -N aws-sso-login

# Get supplier ID JWT
function get-supplier-jwt() {
  BUFFER="~/.local/bachcare/get-supplier-id-token.sh bachcaretechtest+supplier-2198@gmail.com Testing123!"
  zle accept-line
}
zle -N get-supplier-jwt

# -- [[ Keymaps ]] -- 
# Create leader keymap
bindkey -N leader-map

# Lookup table for key -> widget mapping
typeset -A leader_widgets
leader_widgets=(
    'n' 'paste-ticket-number'
    'l' 'aws-sso-login' 
    'j' 'get-supplier-jwt'
)

# Single dispatcher widget
leader-dispatch() {
    local key=$KEYS[-1]  # Get the last pressed key
    local widget=${leader_widgets[$key]}
    
    if [[ -n $widget ]]; then
        zle $widget
    fi
    zle -K main  # Always return to main
}
zle -N leader-dispatch

# Bind all keys to the dispatcher
for key in ${(k)leader_widgets}; do
    bindkey -M leader-map $key leader-dispatch
done

# Quit leader mode
leader-quit() {
  zle -K main
}
zle -N leader-quit

# Activation
activate-leader() { zle -K leader-map }
zle -N activate-leader
bindkey '^b' activate-leader
bindkey -M leader-map '^b' leader-quit
