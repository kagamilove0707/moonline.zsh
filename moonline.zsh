# global variable names (types)
# " description
# 
# MOONLINE_HOME (scalar)
# " a path to directory installing moonlight
#
# MOONLINE_COMPONENTS (association)
# " a hash of component
#
# MOONLINE_SEPRATOR (array) 
# MOONLINE_SUBSEPARATOR (array)
# " strings using as separator.
# " first item is a left separator
# " second item is a right separator
#
# MOONLINE_LEFT1..4 (array)
# MOONLINE_RIGHT1..4 (array)
# MOONLINE_PROMPT (scalar)
# " displaying component(s)
#
# MOONLINE_COLORSCHEME_PATH (array)
# MOONLINE_COLORSCHEME (scalar)
# MOONLINE_COLOR_LEFT1..4 (array)
# MOONLINE_COLOR_RIGHT1..4 (array)
# MOONLINE_COLOR_PROMPT (array)

MOONLINE_HOME="$(cd $(dirname ${0}); pwd)"

# load default settings
for default_file ($MOONLINE_HOME/default/*.zsh); do
  source $default_file
done

moonline_load_colorscheme() {
  local flag=''
  local path
  for path in $moonline_colorscheme_path; do
    if [ -f "$path/$MOONLINE_COLORSCHEME.zsh" ]; then
      source "$path/$MOONLINE_COLORSCHEME.zsh"
      flag='true'
      break
    fi
  done
  if [[ "$flag" = '' ]]; then
    echo "$MOONLINE_COLORSCHEME is not found."
    return 1
  fi
  return 0
}

moonline_initialize() {
  # alias global variables
  local sepl=$MOONLINE_SEPARATOR[1]
  local sepr=$MOONLINE_SEPARATOR[2]
  local subsepl=$MOONLINE_SEPARATOR[1]
  local subsepr=$MOONLINE_SEPARATOR[2]
  local target
  local prompts
  local flag
  local color
  local i
  local left
  local right

  # initialize prompts
  PROMPT=''
  RPROMPT=''

  # set left prompt
  for i in {1..4}; do
    target=(${(z)$(eval "echo \$MOONLINE_LEFT${i}")})
    if [[ 0 < $#target ]]; then
      # set color
      color=(${(z)$(eval "echo \$MOONLINE_COLOR_LEFT${i}")})
      PROMPT+="%{"

      if [[ "$flag" != '' ]]; then
        PROMPT+=$'\e'"[48;5;${color[2]}m%}"
        PROMPT+="$sepl %{"
        PROMPT+=$'\e'"[38;5;${color[1]}m"
      else
        PROMPT+=$'\e'"[48;5;${color[2]}m%}"
        PROMPT+=" %{"
        PROMPT+=$'\e'"[38;5;${color[1]}m"
      fi

      PROMPT+="%}"

      # set content
      prompts=()
      for left in $target; do
        prompts+=(${MOONLINE_COMPONENTS[$left]})
      done
      PROMPT+="${(j: ${subsepl} :)prompts}"

      PROMPT+="%{"$'\e'"[38;5${color[2]}m%} "
      flag='true'
    fi
  done
  if [ "$PROMPT" != '' ]; then
    PROMPT=$'\n'"$PROMPT%{%f%k%} "
  fi

  # set right prompt
  for i in {1..4}; do
    target=(${(z)$(eval "echo \$MOONLINE_RIGHT${i}")})
    if [[ 0 < $#target ]]; then
      # set color
      color=(${(z)$(eval "echo \$MOONLINE_COLOR_RIGHT${i}")})
      RPROMPT+="%{"$'\e'"[38;5;${color[2]}m%}"
      RPROMPT+="$sepr"
      RPROMPT+="%{"
      RPROMPT+=$'\e'"[38;5;${color[1]}m"
      RPROMPT+=$'\e'"[48;5;${color[2]}m"
      RPROMPT+="%}"
      RPROMPT+=" "

      prompts=()
      for right in $target; do
        prompts=(${MOONLINE_COMPONENTS[$right]})
      done
      RPROMPT+="${(j: ${subsepr} :)prompts}"

      RPROMPT+=" "
    fi
  done
  if [ "$RPROMPT" != '' ]; then
    RPROMPT+="%{%f%k%}"
  fi

  # set prompt
  if [ "$MOONLINE_PROMPT" != '' ]; then
    color=($MOONLINE_COLOR_PROMPT)
    PROMPT+=$'\n'
    PROMPT+="%{"
    PROMPT+=$'\e'"[38;5;${color[1]}m"
    PROMPT+=$'\e'"[48;5;${color[2]}m"
    PROMPT+="%}"
    PROMPT+=" $MOONLINE_PROMPT "
    PROMPT+="%{%k"
    PROMPT+=$'\e'"[38;5;${color[2]}m%} "
  fi
}

moonline_load_colorscheme
moonline_initialize
