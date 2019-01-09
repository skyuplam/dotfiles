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
path=(~/.local/bin /usr/local/opt/make/libexec/gnubin /usr/local/sbin /usr/local/bin $path[@])

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

# Bindkey to emac mode
bindkey -e

autoload -Uz compinit #up-line-or-beginning-search down-line-or-beginning-search

compinit

# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

setopt MENU_COMPLETE
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# zstyle ':completion::complete:*' gain-privileges 1

# Directly executing the command (CTRL-X CTRL-R)
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# 
WORDCHARS=''

# }}}
# ---------------------------------------------------------
# Plugins {{{
# ---------------------------------------------------------

# Wrap antibody
source <(antibody init)

# From oh-my-zsh's library
antibody bundle robbyrussell/oh-my-zsh path:plugins/git
antibody bundle robbyrussell/oh-my-zsh path:plugins/pip
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker-compose
antibody bundle robbyrussell/oh-my-zsh path:plugins/z
antibody bundle robbyrussell/oh-my-zsh path:plugins/fzf
antibody bundle robbyrussell/oh-my-zsh path:plugins/colored-man-pages
antibody bundle robbyrussell/oh-my-zsh path:plugins/command-not-found

# Syntax highlighting bundle.
antibody bundle zsh-users/zsh-syntax-highlighting
# ZSH port of Fish history search (up arrow)
antibody bundle zsh-users/zsh-history-substring-search
# Fish-like auto suggestions
antibody bundle zsh-users/zsh-autosuggestions
# Extra zsh completions
antibody bundle zsh-users/zsh-completions
# Prompt
antibody bundle nojhan/liquidprompt

# }}}
# ---------------------------------------------------------
# Plugins Configs {{{
# ---------------------------------------------------------

# ZSH port of Fish history search (up arrow)
# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# fzf
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_LEGACY_KEYBINDINGS=0
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_PREVIEW="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
FZF_SELECT="--select-1 --exit-0"
export FZF_CTRL_T_OPTS="$FZF_PREVIEW $FZF_SELECT"
export FZF_CTRL_R_OPTS="--sort --exact --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# Use Tmux split pane
export FZF_TMUX=1
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

# kubectl
source <(kubectl completion zsh)

# }}}
