{ config, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        theme = "modern";
        icons = "awesome6";

        blocks = [
          {
            block = "cpu";
            interval = 1;
            format = " $icon $utilization ";
          }
          {
            block = "memory";
            format = " $icon $mem_used_percents ";
            format_alt = " $icon_swap $swap_used_percents ";
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            alert_unit = "GB";
            interval = 20;
            warning = 20.0;
            alert = 10.0;
            format = " $icon $available ";
          }
          {
            block = "net";
            format = " $icon {$signal_strength $ssid $frequency} ";
            format_alt = " $icon {$ip} ";
          }
          {
            block = "battery";
            format = " $icon $percentage ";
            missing_format = "";
          }
          {
            block = "sound";
            format = " $icon {$volume|} ";
          }
          {
            block = "time";
            interval = 5;
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          }
        ];
      };
    };
  };
}
