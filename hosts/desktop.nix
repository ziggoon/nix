{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/desktop/i3.nix
    ../modules/common
    ../modules/users
  ];

  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";
}
