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
export BROWSER=firefox-nightly

# GPG
export GPG_TTY=$(tty)

# XDG
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share

typeset -U path
path=(/usr/local/sbin /usr/local/bin $path[@])

# Rust
export RUSTUP_HOME=~/.multirust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# Go
export GOPATH=$XDG_CONFIG_HOME/go
[ -d $GOPATH/bin ] && export PATH=$GOPATH/bin:$PATH
export GO111MODULE=on

# Neovim
export MYINITVIM=$XDG_CONFIG_HOME/nvim/init.vim

# Dropbox
export DROPBOX_DIR=~/Dropbox
export ORG_DIR=$DROPBOX_DIR/org

# Local bin
export PATH=~/.local/bin:$PATH

# Git
export REVIEW_BASE=main

# }}}
# ---------------------------------------------------------
# Zsh general settings {{{
# ---------------------------------------------------------

# Bind history substring search to ctrl-p & ctrl-n
bindkey "∫" backward-word
bindkey "ƒ" forward-word

#
WORDCHARS=''
# }}}
# ---------------------------------------------------------
# Plugins Configs {{{
# ---------------------------------------------------------

# ---------------------------------------------------------
# fzf
# ---------------------------------------------------------

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Gruvbox Dark
export FZF_DEFAULT_OPTS='
  --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
  --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
'
export FZF_CTRL_T_OPTS="--preview='(bat --color=always --line-range :100 {} 2> /dev/null || lsd --tree -l --depth=2 --color=always {} | head -200)'"
# Full command on preview window
# Commands that are too long are not fully visible on screen. We can use
# --preview option to display the full command on the preview window. In the
# following example, we bind ? key for toggling the preview window.
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'lsd --tree --color=always -l --depth=2 {} | head -200'"

# ---------------------------------------------------------
# [bat](https://github.com/sharkdp/bat)
# ---------------------------------------------------------
# colorizing pager for man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# }}}
# ---------------------------------------------------------
# Sourcing other configs {{{
# ---------------------------------------------------------

[ -f ~/.zsh/alias.zsh ] && source ~/.zsh/alias.zsh
[ -f ~/.zsh/local.zsh ] && source ~/.zsh/local.zsh

# ---------------------------------------------------------
# FZF
# ---------------------------------------------------------
# Nix
if [ -d ~/.nix-profile/share/fzf ]; then
  source ~/.nix-profile/share/fzf/key-bindings.zsh
  source ~/.nix-profile/share/fzf/completion.zsh
fi
# Arch Linux
if [ -d /usr/share/fzf ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# ---------------------------------------------------------
# Starship: https://starship.rs
# ---------------------------------------------------------
if type starship > /dev/null; then
  eval "$(starship init zsh)"
fi

# ---------------------------------------------------------
# zoxide: https://github.com/ajeetdsouza/zoxide
# ---------------------------------------------------------
if type zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

# }}}
