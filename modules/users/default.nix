{ config, lib, pkgs, ... }:

{
  users.users.ziggoon = {
    isNormalUser = true;
    description = "ziggoon";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
}
