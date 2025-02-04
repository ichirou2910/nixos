{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/docker.nix
    ../common/fcitx.nix
    ../common/nvidia.nix
    ../common/pipewire.nix
    ../common/systemd-boot.nix

    ./hardware-configuration.nix
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "artemis";
  };

  # NVIDIA Prime
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:2:0:0";
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Kitty overrides
  programs.kitty.font.size = lib.mkForce 11.5;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
