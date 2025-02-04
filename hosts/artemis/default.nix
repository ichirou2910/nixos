{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/optional/docker.nix
    ../common/optional/fcitx.nix
    ../common/optional/nvidia.nix
    ../common/optional/pipewire.nix
    ../common/optional/systemd-boot.nix

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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
