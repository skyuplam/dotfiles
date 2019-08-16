# exa or ls
if type exa > /dev/null; then
  alias ll="exa -lgm --group-directories-first -s modified $argv"
  alias ls="exa $argv"
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

# Emacs
# if type emacs > /dev/null; then
#   alias emacs='emacs -nw'
# fi


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
