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
    brave
    dotnetCorePackages.sdk_6_0
    dotnetCorePackages.sdk_8_0
    jetbrains.rider
    (retroarch.override {
      cores = with libretro; [
        gambatte
        mgba
        snes9x
        swanstation
      ];
    })
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "net.retrodeck.retrodeck"
    ];
  };
  home-manager.users.ichirou.xdg.systemDirs.data = [
    "/var/lib/flatpak/exports/share"
    "/home/ichirou/.local/share/flatpak/exports/share"
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

  # Syncthing (host specific)
  age.secrets.syncthing_cert.file = "${inputs.secrets}/artemis_syncthing.cert.age";
  age.secrets.syncthing_key.file = "${inputs.secrets}/artemis_syncthing.key.age";
  services.syncthing = {
    cert = config.age.secrets.syncthing_cert.path;
    key = config.age.secrets.syncthing_key.path;
    settings = {
      folders = {
        "Ryujinx" = {
          id = "orqvn-yh62h";
          path = "/home/ichirou/.config/Ryujinx/bis/user";
          devices = ["ares" "artemis" "syncthing"];
        };
        "Yuzu" = {
          id = "zncgi-ffzm2";
          path = "/home/ichirou/Games/Emulation/storage/yuzu/nand";
          devices = ["ares" "artemis" "syncthing"];
        };
      };
    };
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
