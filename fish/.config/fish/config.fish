# Load configs from conf.d
# for file in ~/.config/fish/conf.d/*.fish
#     source $file
# end

# import alias
source ~/.config/fish/alias.fish

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
set -x PYTHONIOENCODING 'UTF-8'

# Environment Variables
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x HOMEBREW_NO_ANALYTICS 1
set -x OPENSSL_INCLUDE_DIR (brew --prefix openssl)/include
set -x OPENSSL_LIB_DIR (brew --prefix openssl)/lib
# set -x PATH ANDROID_HOME/tools ANDROID_HOME/platform-tools $PATH
set -x XDG_CONFIG_HOME ~/.config
set -x RUST_SRC_PATH ~/dev/oss/rust/src
set -x RUSTUP_HOME ~/.multirust


# it is a good practice to export VISUAL='mvim -f' to ensure MacVim will not fork a new process when called, which should give you what you want when using it with your shell environment.
# set -x VISUAL 'mvim -f -v'
set -x VISUAL nvim
set -x EDITOR $VISUAL

set -x MYVIMRC ~/.vimrc

# Add GNU core utilities (those that come with macOS are outdated).
set -x PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
# Add GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
set -x PATH /usr/local/opt/findutils/libexec/gnubin $PATH
set -x MANPATH /usr/local/opt/findutils/libexec/gnuman $MANPATH

# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish


# Run Powerline daemon
powerline-daemon -q

# powline fish shell prompt
# set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packagessite-packages/powerline/bindings/fish"
# THEME PURE #
set fish_function_path ~/.config/fish/functions/theme-pure $fish_function_path


# Load private config
source ~/.local.fish
