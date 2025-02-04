{pkgs, lib, ...}: 
let
  win-fonts = pkgs.callPackage ../../pkgs/win-fonts.nix { };
in
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
