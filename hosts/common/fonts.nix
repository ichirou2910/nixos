{pkgs, lib, ...}: 
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FantasqueSansMono" "JetBrainsMono" ]; })
      win-fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "FantasqueSansM Nerd Font" "JetBrainsMono Nerd Font" ];
      };
    };
  };

  fontProfiles = {
    enable = true;
    monospace = {
      family = "Fantasque Sans Mono Nerd Font";
      package = pkgs.nerdfonts.override {fonts = ["FantasqueSansMono" "JetBrainsMono"];};
    };
    regular = {
      family = "Noto";
      package = pkgs.noto-fonts;
    };
  };
}
