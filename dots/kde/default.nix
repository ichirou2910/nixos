{pkgs, ...}: 
{
  imports = [
    ./fonts.nix
    ./hotkeys.nix
    ./kdeconnect.nix
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

  qt = {
    style.package = [
      inputs.lightly.packages.${pkgs.system}.darkly-qt5
      inputs.lightly.packages.${pkgs.system}.darkly-qt6
    ];
    platformTheme.name = "qtct"
  }
}
