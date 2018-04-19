# import alias
source ~/.config/fish/alias.fish

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
set -x PYTHONIOENCODING 'UTF-8'

# Environment Variables
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR nvim
set -x WEECHAT_HOME ~/.config/weechat

# IBus
set -x GTK_IM_MODULE ibus
set -x XMODIFIERS '@im ibus'
set -x QT_IM_MODULE ibus

if command --search brew > /dev/null
  set -x HOMEBREW_NO_ANALYTICS 1
  set -x OPENSSL_INCLUDE_DIR (brew --prefix openssl)/include
  set -x OPENSSL_LIB_DIR (brew --prefix openssl)/lib
end

set -x XDG_CONFIG_HOME ~/.config
set -x XDG_DATA_HOME ~/.config
set -x RUSTUP_HOME ~/.multirust
set -x RUST_SRC_PATH {$RUSTUP_HOME}/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -x GOPATH {$XDG_CONFIG_HOME}/go
test -e {$GOPATH}/bin ; and set -x PATH $GOPATH/bin $PATH

set -x MYVIMRC ~/.vimrc

if command --search brew > /dev/null
  set -x PATH /usr/local/bin $PATH
  set -x PATH /usr/local/sbin $PATH
  # Add GNU core utilities (those that come with macOS are outdated).
  set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
  # Add GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  set -x PATH /usr/local/opt/findutils/libexec/gnubin $PATH
  set -x MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

if command --search powerline-daemon > /dev/null
  # Run Powerline daemon
  powerline-daemon -q
end

test -e {$HOME}/.local/bin ; and set -x PATH $HOME/.local/bin $PATH

# fish prompt bobthefish
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized-dark

# fzf
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
set -U FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x FZF_DEFAULT_OPTS '--color=bg+:#073642,bg:#002b36,spinner:#719e07,hl:#586e75 --color=fg:#839496,header:#586e75,info:#cb4b16,pointer:#719e07 --color=marker:#719e07,fg+:#839496,prompt:#719e07,hl+:#719e07'

# Rust
test -e {$HOME}/.cargo/bin ; and set -x PATH $HOME/.cargo/bin $PATH

 #Load private config
source ~/.local.fish
# THEME PURE #
set fish_function_path /home/terrencelam/.config/fish/functions/theme-pure $fish_function_path

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
