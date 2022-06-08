# exa or ls
# if type exa > /dev/null; then
#   alias ll="exa -lgm --group-directories-first -s modified $argv"
#   alias ls="exa $argv"
# fi
if type nvim > /dev/null; then
  alias vim="nvim"
fi

# lsd to ls
if type lsd > /dev/null; then
  alias ls="lsd"
  alias ll="ls -l"
  alias lt="ls --tree"
fi

# Docker
if type docker-compose > /dev/null; then
  alias dc='docker-compose'
fi

if type tmux > /dev/null; then
  # Create a new tmux session with main-vertical layout with session named as
  # the current dir name
  function tmux-layout() {
    tmux new-session -s $(basename $(pwd)) \; split-window -v -l 30% \; split-window -h -b -l 50% \; select-pane -U \; attach
  }
  alias tm="tmux-layout"
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

# GIT heart FZF
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

git_repo_url() {
  git config remote.origin.url | sed -e "s/:/\//" -e "s/git@/https:\/\//" -e "s/\.git$//"
}

fzf-down() {
  fzf --height 50% "$@" --border
}

_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# Extract Gitlab merge request URL
_gm() {
  is_in_git_repo || return

  git log --merges --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an) %B" --graph --color=always |
  rg "Merge branch" |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --format=%b --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}" |
  xargs git show --format=%b |
  rg -o "![0-9]+" |
  sed -e "s/\s//g" |
  tr -d "!" | read ref

  git_repo_url | read url

  echo "$url/-/merge_requests/$ref"
}

# Key-binding
#
# CTRL-G CTRL-F for files
# CTRL-G CTRL-B for branches
# CTRL-G CTRL-T for tags
# CTRL-G CTRL-R for remotes
# CTRL-G CTRL-H for commit hashes
# CTRL-G CTRL-M for Gitlab MR URL

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h m
unset -f bind-git-helper
