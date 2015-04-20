# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
    useDefaultShell = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    autojump
    emacs
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
      sessionCommands = ''
        ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr
        ${pkgs.feh}/bin/feh --bg-fill "$HOME/.wallpaper.jpg"
      '';
    };
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.default = "xmonad";
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;
    fonts = with pkgs; [
      source-code-pro
    ];
  };
                                     
  programs.zsh.enable = true;
}
