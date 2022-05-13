{ config, pkgs, lib, ... }:

{
  # Packages with configuration --------------------------------------------------------------- {{{

  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  programs.bat.enable = true;
  programs.bat.config = {
    style = "plain";
  };

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  programs.zoxide.enable = true;
  # }}}

  # Other packages ----------------------------------------------------------------------------- {{{

  home.packages = with pkgs; [
    # (pass.withExtensions (exts: [ exts.pass-otp ]))
    abduco # lightweight session management
    aspell
    borgbackup
    bottom # fancy version of `top` with ASCII graphs
    browsh # in terminal browser
    cmake
    coreutils
    curl
    du-dust # fancy version of `du`
    exa # fancy version of `ls`
    fd # fancy version of `find`
    fontconfig
    fzy
    gawk
    # gcc
    git
    gitAndTools.delta
    gnupg
    go
    htop # fancy version of `top`
    hyperfine # benchmarking tool
    lsd
    luajitPackages.luarocks
    neovim-nightly
    ninja
    # passExtensions.pass-import
    passff-host
    procs # fancy version of `ps`
    ripgrep # better version of `grep`
    rsync
    skhd
    slides
    stow
    tealdeer # rust implementation of `tldr`
    tig
    tmux
    tree
    units
    wget
    wasm-pack
    xz # extract XZ archives
    yabai
    yarn
    bash

    # Dev stuff
    cloc # source code line counter
    jq
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    efm-langserver
    nodejs-16_x
    rust-analyzer
    (python3.withPackages (p: with p; [ pip ]))
  ];
  # }}}

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    initExtraBeforeCompInit = "[ -f $HOME/.zsh/init.zsh ] && source $HOME/.zsh/init.zsh";
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    settings = { PASSWORD_STORE_DIR = "$HOME/.password-store"; };
  };

  # Starship Prompt
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.starship.enable
  programs.starship.enable = true;

  # Starship settings -------------------------------------------------------------------------- {{{

  programs.starship.settings = {
    # See docs here: https://starship.rs/config/
    # Symbols config configured in Flake.

    directory.fish_style_pwd_dir_length = 1; # turn on fish directory truncation
    directory.truncation_length = 2; # number of directories not to truncate
    gcloud.disabled = true; # annoying to always have on
    hostname.style = "bold green"; # don't like the default
    memory_usage.disabled = true; # because it includes cached memory it's reported as full a lot
    username.style_user = "bold blue"; # don't like the default
  };
  # }}}

  # This value determines the Home Manager release that your configuration is compatible with. This
  # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You can update Home Manager without changing this value. See the Home Manager release notes for
  # a list of state version changes in each release.
  home.stateVersion = "21.11";
}
# vim: foldmethod=marker
