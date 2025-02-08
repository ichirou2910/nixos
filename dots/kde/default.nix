{ pkgs, inputs, ... }: 
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
    "kdeglobals"."General"."AccentColor" = "146,110,228";

    "kdeglobals"."General"."BrowserApplication" = "brave-browser.desktop";
    "kdeglobals"."General"."TerminalApplication" = "kitty";
    "kdeglobals"."General"."TerminalService" = "kitty.desktop";

    "kwinrc"."Wayland"."InputMethod[$e]" = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";
  };

  # workaround tray.target
  # https://github.com/nix-community/home-manager/issues/2064
  systemd.user.targets.tray = {
		Unit = {
			Description = "Home Manager System Tray";
			Requires = [ "graphical-session-pre.target" ];
		};
	};

  services.kdeconnect = {
    enable = true;
    indicator = false;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  qt = {
    enable = true;
    style.package = with pkgs; [
      kdePackages.kio
      kdePackages.plasma-integration
      kdePackages.systemsettings
      inputs.lightly.packages.${pkgs.system}.darkly-qt5
      inputs.lightly.packages.${pkgs.system}.darkly-qt6
    ];
    style.name = "breeze";
  };
}
