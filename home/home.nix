{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./nvim.nix
    ./modules/zsh.nix 
    ./modules/tmux.nix
    #./modules/i3.nix
    #./modules/i3status-rs.nix
  ];

  home = {
    username = "ziggoon";
    homeDirectory = lib.mkForce "/home/ziggoon";
    stateVersion = "24.11";
    enableNixpkgsReleaseCheck = false;

    packages = with pkgs; [
      fastfetch
      btop
      git
      eza
      curl
      wget
    ];
  };

  programs.home-manager.enable = true;
}
