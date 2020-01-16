{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        aspell
        coreutils
        jq
        skim
        bat
        xclip
        pass
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
    };
  };
}
