{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/fcitx.nix
    ./hardware-configuration.nix
    ./network.nix
    ./nvidia.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];

  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_6_0
    dotnetCorePackages.sdk_8_0
    jetbrains.rider
  ];

  home-manager.users.ichirou.xdg.configFile = {
    "kdeconnect/config" = {
      source = pkgs.writeText "config" ''
        [General]
        name=artemis
        customDevices=10.0.0.3,10.0.0.4,10.0.0.5
      '';
    };
  };

  virtualisation.docker = {
    enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
