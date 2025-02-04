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
    # lsp
    roslyn-ls
    lua-language-server
    nodePackages_latest.typescript-language-server

    # debugger
    netcoredbg

    # formater/linter
    csharpier
    stylua
    shfmt
    eslint_d
    prettierd
  ];
}
