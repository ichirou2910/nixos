{ input, lib, pkgs, ... }: {
  programs = {
    steam.enable = true;
    steam.gamescope.enable = true;
    gamemode.enable = true;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    bottles
  ];
};
