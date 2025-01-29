{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "sudo" ];
      theme = "wezm+";
    };

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
  };
}
