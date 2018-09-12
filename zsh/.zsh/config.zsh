# vim: set foldmethod=marker foldlevel=0 nomodeline:

# ---------------------------------------------------------
# Env {{{
# ---------------------------------------------------------
export HISTFILE=~/.histfile
export HISTSIZE=20000
export SAVEHIST=20000
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

typeset -U path
path=(~/.local/bin /usr/local/bin $path[@])

# Rust
export RUSTUP_HOME=~/.multirust
[ -d $HOME/.cargo/bin ] && export PATH=$HOME/.cargo/bin:$PATH

# Go
export GOPATH=$XDG_CONFIG_HOME/go
[ -d $GOPATH/bin ] && export PATH=$GOPATH/bin:$PATH

# Neovim
export MYINITVIM=$XDG_CONFIG_HOME/nvim/init.vim

# Dropbox
export DROPBOX_DIR=~/Dropbox
export ORG_DIR=$DROPBOX_DIR/org

# nvm
export NVM_DIR=$HOME/.nvm

# Joplin
[ -f $HOME/.joplin-bin/bin/joplin ] && export PATH=$HOME/.joplin-bin/bin:$PATH

# }}}
# ---------------------------------------------------------
# Zsh general settings {{{
# ---------------------------------------------------------

setopt appendhistory autocd beep extendedglob nomatch

bindkey -v

autoload -Uz compinit up-line-or-beginning-search down-line-or-beginning-search

compinit

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

zstyle ':completion::complete:*' gain-privileges 1

# }}}
# ---------------------------------------------------------
# Plugins {{{
# ---------------------------------------------------------

# Please first install [antigen](http://antigen.sharats.me/)
# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
antigen bundle pip
antigen bundle docker
antigen bundle docker-compose
antigen bundle z
antigen bundle fzf
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

# }}}
# ---------------------------------------------------------
# Plugins Configs {{{
# ---------------------------------------------------------

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

# }}}
# ---------------------------------------------------------
# Sourcing other configs {{{
# ---------------------------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh/alias.zsh ] && source ~/.zsh/alias.zsh
[ -f ~/.zsh/local.zsh ] && source ~/.zsh/local.zsh

# }}}
