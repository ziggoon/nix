{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager = {
      gdm.enable = true;
    };
  };

  services.displayManager.defaultSession = "none+i3";

  fonts.packages = with pkgs; [
    font-awesome
    dejavu_fonts
  ];

  environment.systemPackages = with pkgs; [
    dmenu
    i3status
    picom
  ];
}
