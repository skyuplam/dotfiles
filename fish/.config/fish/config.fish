
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

# powline fish shell prompt
# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packagessite-packages/powerline/bindings/fish"
# THEME PURE #
set fish_function_path ~/.config/fish/functions/theme-pure $fish_function_path

# Rust
test -e {$HOME}/.cargo/bin ; and set -x PATH $HOME/.cargo/bin $PATH

 #Load private config
source ~/.local.fish
