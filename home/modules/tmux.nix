{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    prefix = "C-a";
    terminal = "xterm-256color";
    mouse = true;
    
    extraConfig = ''
      bind-key v split-window -h
      bind-key s split-window -v

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set -g status-style 'bg=#333333 fg=#dd7cbb'
    '';
  };
}
