{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/common
    ../modules/users
  ];

  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11";
}
