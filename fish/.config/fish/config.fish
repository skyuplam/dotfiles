
# import alias
source ~/.config/fish/alias.fish

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
set -x PYTHONIOENCODING 'UTF-8'

# Environment Variables
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR vim

set -x HOMEBREW_NO_ANALYTICS 1
set -x OPENSSL_INCLUDE_DIR (brew --prefix openssl)/include
set -x OPENSSL_LIB_DIR (brew --prefix openssl)/lib
set -x XDG_CONFIG_HOME ~/.config
set -x XDG_DATA_HOME ~/.config
set -x RUSTUP_HOME ~/.multirust
set -x RUST_SRC_PATH {$RUSTUP_HOME}/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src

set -x MYVIMRC ~/.vimrc

# Add GNU core utilities (those that come with macOS are outdated).
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
# Add GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
set -x PATH /usr/local/opt/findutils/libexec/gnubin $PATH
set -x MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Run Powerline daemon
powerline-daemon -q

# powline fish shell prompt
# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packagessite-packages/powerline/bindings/fish"
# THEME PURE #
set fish_function_path ~/.config/fish/functions/theme-pure $fish_function_path

# [tiny-care-terminal](https://github.com/notwaldorf/tiny-care-terminal) config
set -gx TTC_BOTS 'tinycarebot,selfcare_bot,magicrealismbot'
set -gx TTC_WEATHER 'Oslo'
set -gx TTC_CELSIUS true
set -gx TTC_APIKEYS true
set -gx TTC_UPDATE_INTERVAL 20  # Refresh the dashboard every 20 minutes

# Rust
set -x PATH $HOME/.cargo/bin $PATH

 #Load private config
source ~/.local.fish
