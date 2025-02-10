{
  programs.plasma.panels =
    let
      appLauncher = {
        kickoff = {
          icon = "nix-snowflake";
        };
      };

      iconTasks = {
        iconTasks = {
          behavior = {
            showTasks = {
              onlyInCurrentScreen = true;
              onlyInCurrentDesktop = true;
              onlyInCurrentActivity = true;
              onlyMinimized = false;
            };
          };
          launchers = [ ];
        };
      };

      cpu = "org.kde.plasma.systemmonitor.cpu";
      memory = "org.kde.plasma.systemmonitor.memory";

      margin = "org.kde.plasma.marginsseparator";

      tray = "org.kde.plasma.systemtray";

      clock = {
        digitalClock = {
          date.format = { 
            custom = "ddd, MMM d, yyyy";
          };
        };
      };
    in
    [
      # main screen
      {
        screen = 0;
        floating = true;
        height = 45;
        hiding = "none";
        lengthMode = "fill";
        location = "bottom";
        widgets = [
          appLauncher
          iconTasks
          cpu
          memory
          margin
          tray
          clock
        ];
      }

      # sub screen etc.
    ];
}
