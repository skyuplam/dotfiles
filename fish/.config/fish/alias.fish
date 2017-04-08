# Utilities
function c        ; pygmentize -O style=monokai -f console256 -g $argv ; end
function g        ; git $argv ; end
function grep     ; command grep --color=auto $argv ; end

# `cat` with beautiful colors. requires Pygments installed.
# sudo easy_install -U Pygments
alias c='pygmentize -O style=monokai,encoding=utf-8 -f console256 -g'

alias j='jq'

alias ag='ag --follow --hidden'

# An orphaned image is one without a tag and it is also not a parent of
# a tagged image. We also call these "dangling" images since they are not
# really connected to an image tree.
# Remove dangling docker images
# alias docker_images_clean='docker rmi (docker images -f dangling=true -q)'
# alias docker_clean='docker rm (docker ps -a -q)'

# it is a good practice to export VISUAL='mvim -f' to ensure MacVim will not
# fork a new process when called, which should give you what you want when using
# it with your shell environment.
# VIM
alias vi vim
# alias vim 'mvim -v -f'
alias vim nvim


# Update installed brew and npm packages
alias brew_update 'brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor; npm-check -g -u; fisher up'

# Useful `tree` aliases
function tree1; tree --dirsfirst -ChFLQ 1 $argv; end
function tree2; tree --dirsfirst -ChFLQ 2 $argv; end
function tree3; tree --dirsfirst -ChFLQ 3 $argv; end
function tree4; tree --dirsfirst -ChFLQ 4 $argv; end
function tree5; tree --dirsfirst -ChFLQ 5 $argv; end
function tree6; tree --dirsfirst -ChFLQ 6 $argv; end

function ll ; tree --dirsfirst -ChFupDaLg 1 $argv ; end

# Quick check running state of a process
alias ps='ps -ef | peco'
alias top='top -o cpu'

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

