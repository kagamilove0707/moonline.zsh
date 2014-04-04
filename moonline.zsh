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
# MOONLINE_COLOR_LEFT_LINE (scalar)
# MOONLINE_COLOR_LEFT{1..$MOONLINE_LEFT_LINE}}_{1..4} (array)
# MOONLINE_COLOR_RIGHT{1..4} (array)
# MOONLINE_COLOR_PROMPT (array)

MOONLINE_HOME="$(cd "$(dirname ${0})"; pwd)"

# load default settings
for default_file ($MOONLINE_HOME/default/*.zsh); do
  source $default_file
done

fpath+=(
  "$MOONLINE_HOME/functions"
)
autoload -Uz moonline-initialize
autoload -Uz moonline-version

moonline() {
  moonline-${1} ${*[2,-1]}
}
