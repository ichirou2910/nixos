{pkgs, ...}: 
{
  imports = [
    ./fonts.nix
    ./hotkeys.nix
    ./panels.nix
    ./workspace.nix
  ];

  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];

  xdg.portal.config = {
    common = {
      default = [
        "kde"
      ];
    };
  };

  programs.plasma.enable = true;
  programs.plasma.configFile = {
    "kdeglobals"."General"."BrowserApplication" = "brave-browser.desktop";
    "kdeglobals"."General"."TerminalApplication" = "kitty";
    "kdeglobals"."General"."TerminalService" = "kitty.desktop";

    "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/fcitx5-wayland-launcher.desktop";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma";
  services.desktopManager.plasma6.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ichirou";
}
