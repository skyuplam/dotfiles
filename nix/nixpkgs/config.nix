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
        skim
        bat
        exa
        lsd
        tig
        ripgrep
        fd
        tree
        neovim
        stow
        xclip
        pass
        tmux
        alacritty
        elmPackages.elm
        elmPackages.elm-format
        elmPackages.elm-test
        elmPackages.elm-analyse
        elmPackages.elm-language-server
        nodejs-13_x
        yarn
        emacs
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
