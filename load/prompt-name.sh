# prompt_name: temporarily override everything after the path in the prompt
# with a custom label (e.g. a feature/branch name of your choosing).
#
#   $ prompt_name feature-a           # prompt becomes:  <path>  feature-a
#   $ prompt_name -c red feature-a    # same, with a red segment
#   $ prompt_name -c 208 feature-a    # 256-color codes work too
#   $ prompt_name                     # restore the normal dir/context/git prompt
#
# Color names/codes are anything zsh's %K accepts (red, blue, magenta, 0-255).
# The override lives only in the current shell and lasts until you clear it
# or close the terminal.

# Default colors for the override segment (bullet-train style: bg fg).
: ${BULLETTRAIN_NAME_BG:=yellow}
: ${BULLETTRAIN_NAME_FG:=black}

# Custom bullet-train segment that renders the override label.
prompt_name_override() {
  [[ -n "$PROMPT_NAME_OVERRIDE" ]] || return
  prompt_segment "${PROMPT_NAME_BG:-$BULLETTRAIN_NAME_BG}" \
                 "${PROMPT_NAME_FG:-$BULLETTRAIN_NAME_FG}" \
                 "$PROMPT_NAME_OVERRIDE"
}

prompt_name() {
  # Remember the normal prompt order the first time we override it, so we can
  # restore it later. Captured lazily because this file is sourced before
  # BULLETTRAIN_PROMPT_ORDER is defined in zshrc.
  if [[ -z "${_PROMPT_NAME_SAVED_ORDER+x}" ]]; then
    _PROMPT_NAME_SAVED_ORDER=("${BULLETTRAIN_PROMPT_ORDER[@]}")
  fi

  # Optional color flags: -c/--color sets the background, --fg the foreground.
  local bg='' fg=''
  while [[ "$1" == -* ]]; do
    case "$1" in
      -c|--color) bg="$2"; shift 2 ;;
      --fg)       fg="$2"; shift 2 ;;
      --)         shift; break ;;
      *) echo "prompt_name: unknown option '$1'" >&2; return 1 ;;
    esac
  done

  if [[ -z "$1" ]]; then
    unset PROMPT_NAME_OVERRIDE PROMPT_NAME_BG PROMPT_NAME_FG
    BULLETTRAIN_PROMPT_ORDER=("${_PROMPT_NAME_SAVED_ORDER[@]}")
    return
  fi

  PROMPT_NAME_OVERRIDE="$*"
  PROMPT_NAME_BG="$bg"
  PROMPT_NAME_FG="$fg"
  BULLETTRAIN_PROMPT_ORDER=(dir name_override)
}
