# # Edit this configuration file to define what should be installed on
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
  # within virtualbox only
  boot.initrd.checkJournalingFS = false;
  boot.kernelPackages = pkgs.linuxPackages_4_6;

  networking.hostName = "nixos-1603"; # Define your hostname.
  networking.enableIPv6 = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nixpkgs.config.allowUnfree = true;
  # be a bit more developer friendly (don't collect built-time only deps)
  nix.extraOptions = ''
    gc-keep-outputs = true
    gc-keep-derivations = true
  '';

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "be-latin1";
    defaultLocale = "en_US.UTF-8";
  } ;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    asciidoctor
    aspell
    aspellDicts.en
    aspellDicts.fr
    autojump
    bundix
    cabal2nix
    chromium
    docker
    emacs
    entr
    ghc
    gitFull
    gnupg
    gnumake
    haskellPackages.xmobar
    haskellPackages.shake
    haskellPackages.stack
    haskellPackages.hlint
    haskellPackages.stylish-haskell
    hiera-eyaml
    htop
    jq
    nix-repl
    neovim
    parallel
    pandoc
    pythonFull
    pythonPackages.pip
    pythonPackages.ipython
    pythonPackages.jedi
    ruby
    shellcheck
    silver-searcher
    tree
    vault
    unzip
    wget
    which
    xfce.terminal
    zeal
    zip
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "be";
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.default = "xmonad";
    xkbOptions = "caps:escape";
    #desktopManager.xterm.enable = false;
    desktopManager.default = "none";
    displayManager = {
      lightdm = {
        enable = true;
        autoLogin.user= "nix";
        autoLogin.enable= true;
      };
      sessionCommands = ''
        ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr
        ${pkgs.feh}/bin/feh --bg-scale "$HOME/.wallpaper.jpg"
      '';
    };
  };
  # services.xserver.xkbOptions = "eurosign:e";

  fonts = {
 #   enableCoreFonts = true;
    enableFontDir = true;
    fonts = [ pkgs.source-code-pro ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.nix = {
    createHome = true;
    home = "/home/nix";
    isSystemUser = true;
    extraGroups = [ "wheel" "disk" "vboxusers" "docker"];
    shell = "/run/current-system/sw/bin/bash";
    uid = 1000;
  };

  programs.bash.enableCompletion = true;
  programs.bash.shellAliases = {
    du = " du -h" ;
    df = " df -h" ;
    la = " ls -lah" ;
    ag = "ag --color-line-number=2" ;
    vim = "nvim" ;
    build = "./build/build.sh" ;
    see = "./bin/check_role.sh" ;
  };
  programs.bash.shellInit = ''
    shopt -s autocd

    function presources () {
        puppetresources -p . -o "$1" --hiera ./tests/hiera.yaml --pdbfile tests/facts.yaml ''${@:2}
    }

    #. $(autojump-share)/autojump.bash
  '';
  programs.bash.promptInit = ''
    # Provide a nice prompt if the terminal supports it.
    if [ "$TERM" != "dumb" -o -n "$INSIDE_EMACS" ]; then
      PROMPT_COLOR="1;31m"
      let $UID && PROMPT_COLOR="1;32m"
      PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
      if test "$TERM" = "xterm"; then
        export PS1='\w\[\033[01;38m\]''$(__git_ps1)\[\033[00m\] → '
      fi
    fi
  '';
  security.sudo.wheelNeedsPassword = false;

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--insecure-registry docker.cirb.lan --insecure-registry docker.sandbox.srv.cirb.lan";
  virtualisation.virtualbox.guest.enable = true;

  fileSystems."/vbox/shared" = {
     fsType = "vboxsf";
     device = "shared";
     options = [ "rw" ];
  };

  fileSystems."/vbox/notebook" = {
     fsType = "vboxsf";
     device = "notebook";
     options = [ "rw" ];
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

}
