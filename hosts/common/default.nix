{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./kde
    ./brave.nix
    ./fonts.nix
    ./git.nix
    ./nvim.nix
    ./syncthing.nix
    ./vscode.nix
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

  # Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  environment.systemPackages = with pkgs; [
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
