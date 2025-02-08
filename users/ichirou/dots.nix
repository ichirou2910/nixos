{ pkgs, ... }:
let
  home = {
    username = "ichirou";
    homeDirectory = "/home/ichirou";
    stateVersion = "24.11";
  };
in
{

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = home;

  imports = [
    ../../dots/git
    ../../dots/kde
    ../../dots/kitty
    ../../dots/nvim
    ../../dots/zsh
    ./packages.nix
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
    ];
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
