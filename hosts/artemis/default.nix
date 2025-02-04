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

    ./hardware-configuration.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
  ];

  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_6_0
    dotnetCorePackages.sdk_8_0
    jetbrains.rider
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "artemis";
    firewall = {
      logReversePathDrops = true;
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51820 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51820 -j RETURN || true
      '';
    };
  };
  systemd.user.services.wireguard = {
    enable = true;
    wantedBy = ["default.target"];
    after = ["network-online.target"];
    description = "Connect to WireGuard VPN (Home) after internet is available";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c 'until ping -c 1 -W 1 8.8.8.8; do sleep 2; done; nmcli connection up wg0'
      '';
      ExecStop= ''
        ${pkgs.networkmanager}/bin/nmcli connection down wg0
      '';
      RemainAfterExit=true;
    };
  };

  home-manager.users.ichirou.xdg.configFile = {
    "kdeconnect/config" = {
      source = pkgs.writeText "config" ''
        [General]
        name=artemis
        customDevices=10.0.0.3,10.0.0.4,10.0.0.5
      '';
    };
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
