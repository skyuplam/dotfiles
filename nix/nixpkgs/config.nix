{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        aspell
        coreutils
        jq
        skim
      ];
      pathsToLink = [ "/share" "/bin" "/Applications" ];
    };
  };
}
