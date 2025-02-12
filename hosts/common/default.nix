{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./fonts.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  programs.ssh = {
    extraConfig = ''
      Host github.com
        IdentityFile ~/.ssh/id_ed25519
    '';
    startAgent = true;
  };

  # Syncthing (common)
  services.syncthing = {
    enable = true;
    user = "ichirou";
    dataDir = "/home/ichirou";
    configDir = "/home/ichirou/.config/syncthing";
    openDefaultPorts = true;
    settings = {
      devices = {
        "ares" = { id = "V4EBFRS-YZE26P2-NOWDU43-IGBNGCA-ZM4FJ7X-3JXLKRL-JRC6SQ6-BVZU5AL"; };
        "artemis" = { id = "AYXRNZW-GNGFPBW-T43UBGI-KU2DX4Q-JKWHGTX-5QOUBXH-RXZRH3K-SPCC6AF"; };
        "syncthing" = { id = "4GREEPA-XQJA4IL-FUBEJTG-PSABT47-5ECVUR7-3G6W3DO-V7Y32UK-BF7VYAE"; };
      };
    };
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";

  # KDE Plasma
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ichirou";
  # KDE Connect
  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  # Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    alejandra
    atool
    bash
    dig
    distrobox
    eza
    fd
    gcc
    git-crypt
    htop
    inetutils
    inputs.agenix.packages."${system}".default
    jq
    pciutils
    unzip
    usbutils
    util-linux
    remmina
    ripgrep
    termius
    tmux
    vesktop
    yadm
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    settings = {
      max-jobs = "auto";
      trusted-users = [
        "root"
        "ichirou"
      ];
    };
  };
}
