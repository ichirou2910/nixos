{ input, lib, pkgs, ... }: {
  programs = {
    bash.enable = true;
    bat.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fastfetch.enable = true;
    firefox.enable = true;
    fzf.enable = true;
    nnn.enable = true;
  };
}
