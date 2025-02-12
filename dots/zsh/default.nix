{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [ zsh-fzf-tab ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      eval "$(fzf --zsh)"
    '';

    dotDir = ".config/zsh";

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Tweak settings for history
    history = {
      save = 10000;
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };

    # Set some aliases
    shellAliases = {
      g = "git";
      ka = "killall";
      se = "sudo -e";

      y = "yadm";
      dfe = "yadm enter nvim";

      mkdir = "mkdir -vp";
      rm = "rm -rifv";
      mv = "mv -iv";
      cp = "cp -riv";
      cat = "bat --paging=never --style=plain";
      tree = "exa --tree --icons";
      nd = "nix develop -c $SHELL";
      q = "exit";

      ls = "exa";
      ll = "exa -lh -g --icons";
      lla = "ll -a";

      tas="tmux attach-session";
      ta="tmux attach || tmux new-session";
      td="tmux detach";
    };

    plugins = [
      {
          name = "powerlevel10k-config";
          src = ./p10k;
          file = "p10k.zsh";
      }
      {
          name = "zsh-powerlevel10k";
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
      }
    ];
  };
}
