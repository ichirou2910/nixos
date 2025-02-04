{pkgs, lib, ...}: 
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
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
}
