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
