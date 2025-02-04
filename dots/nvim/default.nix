{ pkgs, lib, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = with pkgs; [
    csharpier
    eslint_d
    lua-language-server
    netcoredbg
    nodejs
    nodePackages_latest.typescript-language-server
    prettierd
    roslyn-ls
    shfmt
    stylua
  ];
}
