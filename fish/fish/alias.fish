# Utilities
function c        ; pygmentize -O style=monokai -f console256 -g $argv ; end
function g        ; git $argv ; end
# function grep     ; command rg --color=auto $argv ; end

# `cat` with beautiful colors. requires Pygments installed.
# sudo easy_install -U Pygments
# alias c='pygmentize -O style=monokai,encoding=utf-8 -f console256 -g'

# alias ag='ag --follow --hidden'

# An orphaned image is one without a tag and it is also not a parent of
# a tagged image. We also call these "dangling" images since they are not
# really connected to an image tree.
# Remove dangling docker images
# alias docker_images_clean='docker rmi (docker images -f dangling=true -q)'
# alias docker_clean='docker rm (docker ps -a -q)'
# Docker
if command --search docker > /dev/null
  alias d="docker"
  alias dc="docker-compose"
end

if command --search xclip > /dev/null
  alias xclip="xclip -selection c"
end

# it is a good practice to export VISUAL='mvim -f' to ensure MacVim will not
# fork a new process when called, which should give you what you want when using
# it with your shell environment.
# VIM
# alias vi vim
# alias vim 'mvim -v -f'
if command --search nvim > /dev/null
  alias vim='nvim'
end

# AWS login credential
if command --search aws > /dev/null
  alias awslogin="aws ecr get-login --region eu-west-1 | source"
end

# rust-clippy linter
if command --search clippy > /dev/null
  alias clippy="cargo rustc -q --features=clippy -- -Z no-trans -Z extra-plugins=clippy"
end

# Update installed brew and npm packages
if command --search brew > /dev/null
  alias brew_update="brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor; fisher up; rustup update"
end

# Update python packages with pip
if command --search pip > /dev/null
  alias pip_update="pip list --outdated --format=freeze | cut -d = -f 1 | xargs sudo -H pip install -U"
end

# Useful `tree` aliases
# if command --search tree > /dev/null
#   function tree1; tree --dirsfirst -ChFLQ 1 $argv; end
#   function tree2; tree --dirsfirst -ChFLQ 2 $argv; end
#   function tree3; tree --dirsfirst -ChFLQ 3 $argv; end
#   function tree4; tree --dirsfirst -ChFLQ 4 $argv; end
#   function tree5; tree --dirsfirst -ChFLQ 5 $argv; end
#   function tree6; tree --dirsfirst -ChFLQ 6 $argv; end

#   function ll ; tree --dirsfirst -ChFupDaLg 1 $argv ; end
# end

if command --search exa > /dev/null
  function ll ; exa -lgm --group-directories-first -s modified $argv ; end
  function ls ; exa $argv ; end
end

# Quick check running state of a process
# alias ps='ps -ef | peco'

# Completions
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

make_completion g 'git'
make_completion d 'docker'
make_completion dc 'docker-compose'


# pip fish completion start
function __fish_complete_pip
    set -lx COMP_WORDS (commandline -o) ""
    set -lx COMP_CWORD (math (contains -i -- (commandline -t) $COMP_WORDS)-1)
    set -lx PIP_AUTO_COMPLETE 1
    string split \  -- (eval $COMP_WORDS[1])
end
complete -fa "(__fish_complete_pip)" -c pip
# pip fish completion end
