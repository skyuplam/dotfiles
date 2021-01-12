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
        aspell
        coreutils
        gnupg
        curl
        git
        jq
        fzf
        bat
        exa
        lsd
        tig
        ripgrep
        fd
        tree
        stow
        xclip
        passff-host
        passExtensions.pass-import
        (pass.withExtensions (exts: [ exts.pass-otp ]))
        tmux
        nodejs-14_x
        yarn
        emacs
        htop
        bandwhich
        broot
        gawk
        go
        gitAndTools.delta
        # gitAndTools.gitui
        nmap
        shellcheck
        hadolint
        shfmt
        starship
        ncdu
        universal-ctags
        kitty
        stack
        darcs
        vim
        zoxide
        broot
        mpv
        fontconfig
        units
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
