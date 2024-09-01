{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "rxored";
  home.homeDirectory = "/home/rxored";
  
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; }))
    pkgs.dunst
    
    pkgs.libnotify
    pkgs.eww 
    pkgs.neovide
    pkgs.wofi
    pkgs.rofi-wayland
    pkgs.btop
    pkgs.hyprpaper
    pkgs.go
    pkgs.openjdk
    pkgs.telegram-desktop   
    pkgs.rustc
    pkgs.cargo
    pkgs.rust-analyzer
    pkgs.discord 
    pkgs.nodejs
    pkgs.unzip
    pkgs.emacs
    pkgs.inconsolata-nerdfont
    pkgs.inconsolata-nerdfont
    pkgs.helix
    pkgs.xclip
    pkgs.ripgrep 
    (pkgs.nerdfonts.override { fonts = [ "SpaceMono" "FiraCode" "FantasqueSansMono" "RobotoMono" "JetBrainsMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
    
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  	"discord"
  ];

  home.file = {
    ".config/hypr/hyprland.conf".source = ./home-config/.config/hypr/hyprland.conf;
    ".config/kitty/kitty.conf".source = ./home-config/.config/kitty/kitty.conf;
    ".config/hypr/hyprpaper.conf".source = ./home-config/.config/hypr/hyprpaper.conf;
  };
 
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Jayod Bandara";
    userEmail = "rxored@gmail.com";
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./home-config/.config/nushell/config.nu;
    extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
      '';
    shellAliases = {
      nano = "hx";
    };
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = false;

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      # package.disabled = true;
    };
  };
}
