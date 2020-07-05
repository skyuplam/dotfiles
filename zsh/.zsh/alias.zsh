# exa or ls
# if type exa > /dev/null; then
#   alias ll="exa -lgm --group-directories-first -s modified $argv"
#   alias ls="exa $argv"
# fi

# lsd to ls
if type lsd > /dev/null; then
  alias ls="lsd"
  alias ll="ls -l"
  alias lt="ls --tree"
fi

# vim or nvim
if type nvim > /dev/null; then
  alias vim="nvim"
  alias vi="nvim"
fi

# Docker
if type docker-compose > /dev/null; then
  alias dc='docker-compose'
fi

if type tmux > /dev/null; then
  # Create a new tmux session with main-vertical layout with session named as
  # the current dir name
  function tmux-layout() {
    tmux new-session -s $(basename $(pwd)) \; split-window -v -p 30 \; split-window -h \; select-pane -U \; attach
  }
  alias tm="tmux-layout"
fi

if type yabai > /dev/null; then
  # Quickly restart yabai launch agent
  # https://github.com/koekeishiya/yabai/wiki/Tips-and-tricks#quickly-restart-the-yabai-launch-agent
  alias ry="launchctl kickstart -k \"gui/${UID}/homebrew.mxcl.yabai\""
fi


if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
  function man-preview() {
    man -t "$@" | open -f -a Preview
  }

  function quick-look() {
    (( $# > 0 )) && qlmanage -p $* &>/dev/null &
  }

  # Man page to Preview
  alias manp='man-preview'
  # Show/hide hidden files in the Finder
  alias showfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hidefiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
fi

# skim with preview
# function skk() {
#   if [ -n "$1" ]
#   then
#     sk --ansi -i -c "rg --line-number --column --color \"always\" $1" --preview "$FZF_PREVIEW_SH {}" fi
# }

# new Zettelkasten note
function zet() {
  if [ -n "$1" ]; then
    nvim "+Zet $*"
  fi
}

# edit Zettel note with nvim
function lz() {
  nvim $(fd --hidden --follow --exclude '.git' . $NOTES_DIR | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
function fo() (
  IFS=$'\n' out=("$(fzf-tmux --query="$1" -1 -0 -m --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
)

# zsh; needs setopt re_match_pcre. You can, of course, adapt it to your own shell easily.
function tmuxkillf() {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}

unalias v
function v() {
  [ $# -gt 0 ] && fasd -f -e ${EDITOR} "$*" && return
  local file
  file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort -m)" && ${EDITOR:-vim} "${file}" || return 1
}
