# Taken from... somewhere?
#
function iterm_tab_color() {
  if [ $# -eq 0 ]; then
    # Reset tab color if called with no arguments
    echo -ne "\033]6;1;bg;*;default\a"
    return 0
  elif [ $# -eq 1 ]; then
    if ( [[ $1 == \#* ]] ); then
      # If single argument starts with '#', skip first character to find hex value
      RED_HEX=${1:1:2}
      GREEN_HEX=${1:3:2}
      BLUE_HEX=${1:5:2}
    else
      # If single argument doesn't start with '#', assume it's hex value
      RED_HEX=${1:0:2}
      GREEN_HEX=${1:2:2}
      BLUE_HEX=${1:4:2}
    fi

    RED=$(( 16#${RED_HEX} ))
    GREEN=$(( 16#${GREEN_HEX} ))
    BLUE=$(( 16#${BLUE_HEX} ))

    echo -ne "\033]6;1;bg;red;brightness;$RED\a"
    echo -ne "\033]6;1;bg;green;brightness;$GREEN\a"
    echo -ne "\033]6;1;bg;blue;brightness;$BLUE\a"

    return 0
  fi

  # If more than 1 argument, assume 3 arguments were passed
  echo -ne "\033]6;1;bg;red;brightness;$1\a"
  echo -ne "\033]6;1;bg;green;brightness;$2\a"
  echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
_tabcolor_on_cwd_change() { iterm_tab_color $(echo $PWD | shasum | cut -c1-6); };
_tabcolor_on_cwd_change
typeset -ga chpwd_functions
set -A chpwd_functions _tabcolor_on_cwd_change
