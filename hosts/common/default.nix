{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./brave.nix
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

  # Syncthing
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";

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
    dotnetCorePackages.sdk_6_0
    dotnetCorePackages.sdk_8_0
    alejandra
    atool
    bash
    dig
    distrobox
    eza
    fd
    htop
    inetutils
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
