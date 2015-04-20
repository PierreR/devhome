# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos"; # Define your hostname.
  networking.hostId = "115c20da";
  # networking.wireless.enable = true;  # Enables wireless.

  # Select internationalisation properties.
  i18n = {
     consoleFont = "lat9w-16";
     consoleKeyMap = "be-latin1";
     defaultLocale = "en_US.UTF-8";
  };
  users.extraUsers.pierre = {
    createHome = true;
    home = "/home/pierre";
    description = "Pierre Radermecker";
    extraGroups = [ "wheel" "disk" "vboxusers"];
    isSystemUser = true;
    shell = "/run/current-system/sw/bin/zsh";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    autojump
    emacs
    docker
    feh
    gitFull
    haskellPackages.xmobar
    htop
    nix-prefetch-scripts
    nix-repl
    rxvt_unicode
    silver-searcher
    unzip
    vim
    wget
    xlibs.xset
    zip
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # services.xserver.xkbOptions = "eurosign:e";
  services.virtualboxGuest.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "be";
    desktopManager.xterm.enable = false;
    desktopManager.default = "none";

    displayManager = {
      slim = {
       	enable = true;
       	defaultUser = "pierre";
      };
      sessionCommands = ''
        ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr
        sh /home/pierre/.fehbg
      '';
    };
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.default = "xmonad";
    xkbOptions = "caps:escape";
  };
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;
    fonts = with pkgs; [
      source-code-pro
    ];
  };

  time.timeZone = "Europe/Brussels";
  programs.zsh.enable = true;
}
