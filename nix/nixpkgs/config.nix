{
  packageOverrides = pkgs: with pkgs; rec {

    # Override packages
    yarn = pkgs.yarn.override { nodejs = nodejs-14_x; };

    myProfile = writeText "my-profile" ''
      export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/sbin:/bin:/usr/sbin:/usr/bin
      export MANPATH=$HOME/.nix-profile/share/man:/nix/var/nix/profiles/default/share/man:/usr/share/man
    '';

    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        (pass.withExtensions (exts: [ exts.pass-otp ]))
        aspell
        bat
        borgbackup
        broot
        broot
        # coreutils
        curl
        darcs
        emacs
        exa
        fd
        fontconfig
        fzf
        gawk
        git
        gitAndTools.delta
        gnupg
        go
        # hadolint
        htop
        jq
        kitty
        lsd
        mpv
        ncdu
        nmap
        nodejs-14_x
        passExtensions.pass-import
        passff-host
        python3
        python38Packages.pip
        ripgrep
        shellcheck
        shfmt
        skhd
        stack
        starship
        stow
        tig
        tree
        units
        # universal-ctags
        vim
        xclip
        yabai
        yarn
        zoxide
        rsync
        nodePackages.typescript-language-server
        nodePackages.vscode-json-languageserver-bin
        nodePackages.vscode-css-languageserver-bin
        nodePackages.vscode-html-languageserver-bin
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
