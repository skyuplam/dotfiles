
# import alias
source ~/.config/fish/alias.fish

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
set -x PYTHONIOENCODING 'UTF-8'

# Environment Variables
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR vim

if command --search brew > /dev/null do
  set -x HOMEBREW_NO_ANALYTICS 1
  set -x OPENSSL_INCLUDE_DIR (brew --prefix openssl)/include
  set -x OPENSSL_LIB_DIR (brew --prefix openssl)/lib
end

set -x XDG_CONFIG_HOME ~/.config
set -x XDG_DATA_HOME ~/.config
set -x RUSTUP_HOME ~/.multirust
set -x RUST_SRC_PATH {$RUSTUP_HOME}/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -x MYVIMRC ~/.vimrc

if command --search brew > /dev/null do
  # Add GNU core utilities (those that come with macOS are outdated).
  set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
  # Add GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  set -x PATH /usr/local/opt/findutils/libexec/gnubin $PATH
  set -x MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH
end

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

if command --search powerline-daemon > /dev/null do
  # Run Powerline daemon
  powerline-daemon -q
end

test -e {$HOME}/.local/bin ; and set -x PATH $HOME/.local/bin $PATH

# fish prompt pure
# Change the colors
set pure_color_blue (set_color "2196F3")
set pure_color_cyan (set_color "80DEEA")
set pure_color_gray (set_color "BDBDBD")
set pure_color_green (set_color "00E676")
set pure_color_normal (set_color "00E5FF")
set pure_color_red (set_color "F44336")
set pure_color_yellow (set_color "FFFF00")

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
