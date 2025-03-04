{ config, pkgs, inputs, ... }:
{

  imports = [ 
    ./hardware-configuration.nix  #DO NOT USE MINE! USE YOUR OWN HARDWARE CONFIGURATION
    ../../modules/nixos
    inputs.home-manager.nixosModules.default
  ];

  # Additional packages if needed
  environment.systemPackages = with pkgs; [
    gh
    git
    lxqt.lxqt-policykit
    kicad
    uv
    python39
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
        github.copilot
      ];
    })
    asunder
    makemkv
    vlc
    heroic
    
  ];

  # Minimal system configuration. Setting locale, keyboard, enabling flakes, home-manager etc.
  # Locale and Keyboard
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ukimnix = {
    isNormalUser = true;
    description = "Kim";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Home Manager Configuration
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "ukimnix" = import ../../home-manager/users/ukimnix.nix;
    };
  };

  # No touchie
  system.stateVersion = "24.05";

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    gfxmodeBios = "1280x1024";
    gfxmodeEfi = "1280x1024";
  };

  #Hyprland so SDDM can see it
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.tailscale.enable = true; 

  # Automatic garbage collection. And some optimization
  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };


}
