# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

export ZIM_HOME=~/.zim
# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# --------------------
# Module configuration
# --------------------

#
# completion
#

# Set a custom path for the completion dump file.
# If none is provided, the default ${ZDOTDIR:-${HOME}}/.zcompdump is used.
#zstyle ':zim:completion' dumpfile "${ZDOTDIR:-${HOME}}/.zcompdump-${ZSH_VERSION}"

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=10'

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi


# ------------------
# Initialize modules
# ------------------
if [[ ${ZIM_HOME}/init.zsh -ot ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  # Update static initialization script if it's outdated, before sourcing it
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# }}} End configuration added by Zim install

# vim: set foldmethod=marker foldlevel=0 nomodeline:

# source nix-zsh-completions
[ -d $HOME/dev/nix-zsh-completions ] && source $HOME/dev/nix-zsh-completions/nix-zsh-completions.plugin.zsh

# ZSH completion folder
# [ -d $HOME/.zfunc ] && fpath=($HOME/.zfunc $fpath)
[ -d $HOME/dev/nix-zsh-completions ] && fpath=($HOME/dev/nix-zsh-completions $fpath)
[ -d $HOME/.nix-profile/share/zsh/site-functions ] && fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
[ -d /usr/local/share/zsh/site-functions ] && fpath=(/usr/local/share/zsh/site-functions $fpath)
[ -d /opt/homebrew/share/zsh/site-functions ] && fpath=(/opt/homebrew/share/zsh/site-functions(N) ${fpath})

export HOMEBREW_NO_ANALYTICS=1
# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

export LC_ALL=en_US.UTF-8

# Ignore git files
# export SKIM_DEFAULT_COMMAND="fd --type f || git ls-tree -r --name-only HEAD || rg --files || find ."

[ -f $HOME/.zsh/config.zsh ] && source $HOME/.zsh/config.zsh

if [ -e /Users/terrencelam/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/terrencelam/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# luarocks local bin folder
export PATH="$HOME/.luarocks/bin:$PATH"

alias luamake=/Users/terrencelam/dev/lua-language-server/3rd/luamake/luamake

# Fix gcc ld issue when using the one from nix
# https://stackoverflow.com/questions/71788323/how-should-i-resolve-a-ld-library-not-found-for-liconv-error-when-running-c
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.nix-profile/lib:/Library/Developer/CommandLineTools/usr/lib
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/System/Library/Frameworks/

