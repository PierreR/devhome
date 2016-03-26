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

  networking.hostName = "prixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  i18n = {
  #   consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "be-latin1";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.en
    aspellDicts.fr
    autojump
    cabal2nix
    emacs
    docker
    feh
    firefox
    gitFull
    gnupg
    gnumake
    haskellPackages.xmobar
    haskellPackages.hasktags
    haskellPackages.ghc-mod
    haskellPackages.stylish-haskell
    haskellPackages.pandoc
    htop
    nix-prefetch-scripts
    nix-repl
    postgresql
    ruby
    rxvt_unicode
    silver-searcher
    unzip
    vim
    wget
    xlibs.xset
    xfce.terminal
    zip
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # Enable the X11 windowing system.
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
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.kdm.enable = false;
  services.xserver.desktopManager.kde4.enable = false;

  # fonts
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;
    fonts = with pkgs; [
      source-code-pro
    ];
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.pierre = {
     createHome = true;
     home = "/home/pierre";
     description = "Pierre Radermecker";
     isSystemUser = true;
     extraGroups = [ "wheel" "disk" "vboxusers" "docker"];
     shell = "/run/current-system/sw/bin/zsh";
  #   uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
  programs.zsh.enable = true;
  programs.bash.enableCompletion = true;
  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--insecure-registry docker.cirb.lan --insecure-registry docker.sandbox.srv.cirb.lan";
  # mount shared virtualbox folder
  fileSystems."/vbox/shared" = {
     fsType = "vboxsf";
     device = "shared";
     # options = "rw";
  };

  fileSystems."/vbox/notebook" = {
     fsType = "vboxsf";
     device = "notebook";
     # options = "rw";
  };

  programs.ssh.startAgent = true;

  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    environment = {
      GTK_DATA_PREFIX = config.system.path;
      SSH_AUTH_SOCK = "%t/ssh-agent";
      GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
      NIX_USER_PROFILE_DIR = "/nix/var/nix/profiles/per-user/pierre";
    };
    serviceConfig = {
       Type = "forking";
       ExecStart = "${pkgs.zsh}/bin/zsh -c 'source ${config.system.build.setEnvironment}; exec emacs --daemon'";
       # ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
       ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
       Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };
  systemd.services.emacs.enable = true;
}
