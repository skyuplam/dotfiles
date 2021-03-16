self: super: {
  tmux = super.tmux.overrideAttrs (old: {
    pname = "tmux";
    version = "3.2-rc";

    src = super.pkgs.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      rev = "3.2-rc";
      sha256 = "01yi6s3db0ba1s5kz07227vjkmcrw5pijfd64gwmqvx47iwz5vlc";
    };
  });
}
