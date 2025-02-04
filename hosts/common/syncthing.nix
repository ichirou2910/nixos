{ pkgs, ... } : {
  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
      package = pkgs.syncthingtray;
    };
  };

  environment.systemPackages = with pkgs; [
    syncthingtray
  ];
}
