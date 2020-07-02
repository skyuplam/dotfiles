{
  packageOverrides = pkgs: with pkgs; rec {
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
        pass
        tmux
        nodejs-13_x
        yarn
        emacs
        htop
        bandwhich
        broot
        gawk
        nnn
        go
        gitAndTools.delta
        nmap
        shellcheck
        hadolint
        shfmt
        starship
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
