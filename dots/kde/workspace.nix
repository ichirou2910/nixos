{ pkgs, ... } :
{
  programs.plasma.workspace = {
    colorScheme = "BreezeDark";
    splashScreen.theme = "None";
    windowDecorations = {
      library = "org.kde.darkly";
      theme = "Darkly";
    };
  };
}
