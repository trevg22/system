# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {

    # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];
  
  programs.zsh={
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch --flake .";
    nvim="flatpak run io.neovim.nvim";
  };
  };
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "trevor";
    homeDirectory = "/home/trevor";
  };

  # Add stuff for your user as you see fit:
   home.packages = with pkgs; [ librewolf flatpak 
   zellij keepassxc discord spotify nodejs
	unzip zip clang cmake gnumake python3 qt5.full boost
	libreoffice-qt logseq thunderbird glxinfo libGLU
	alacritty jam clang-tools sublime-merge
	flatpak-builder ripgrep-all pipx lazygit qbittorrent
	qalculate-qt fuzzel foot pulsemixer wowup-cf fzf
	rustup eza zoxide starship htop gradle android-studio
	steam-run pkgs-unstable.neovim 
	];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "Trevor";
    userEmail = "trevor@trevg.xyz";
  };


  programs.firefox = {
    enable = true;
    profiles.trevor = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        ublock-origin
        keepassxc-browser
      ];

    };
  };

    # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
