HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000

setopt appendhistory autocd beep extendedglob nomatch
bindkey -v
autoload -Uz compinit; compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# ---------------------------------------------------------
# Plugins
# ---------------------------------------------------------

# Please first install [antigen](http://antigen.sharats.me/)
# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle docker
antigen bundle docker-compose
antigen bundle z
antigen bundle colored-man-pages
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# Fish-like auto suggestions
antigen bundle zsh-users/zsh-autosuggestions
# Extra zsh completions
antigen bundle zsh-users/zsh-completions


# Load the theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done
antigen apply

# ---------------------------------------------------------
# Env
# ---------------------------------------------------------
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim

# IBus
export GTK_IM_MODULE=ibus
export XMODIFIERS='@im ibus'
export QT_IM_MODULE=ibus

# GPG
export GPG_TTY=$(tty)

# XDG
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share

# Rust
export RUSTUP_HOME=~/.multirust
[ -f $HOME/.cargo/bin ] && export PATH=$HOME/.cargo/bin:$PATH

# Go
export GOPATH=$XDG_CONFIG_HOME/go
[ -f $GOPATH/bin ] && export PATH=$GOPATH/bin:$PATH

# Neovim
export MYINITVIM=$XDG_CONFIG_HOME/nvim/init.vim

# Dropbox
export DROPBOX_DIR=~/Dropbox
export ORG_DIR=$DROPBOX_DIR/org

# nvm
export NVM_DIR=$HOME/.nvm


# fzf
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_LEGACY_KEYBINDINGS=0
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_BG='--color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75'
FZF_FG='--color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07'
FZF_MARKER='--color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07'
export FZF_DEFAULT_OPTS="$FZF_BG $FZF_FG $FZF_MARKER"

# ---------------------------------------------------------
# Sourcing other configs
# ---------------------------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh/alias.zsh ] && source ~/.zsh/alias.zsh
[ -f ~/.zsh/local.zsh ] && source ~/.zsh/local.zsh
