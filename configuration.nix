# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    # To generate a new hardware-configuration.nix use
    # sudo nixos-generate-config --dir .
    ./hardware-configuration.nix
  ];

  # If you put this code in hardware-configuration.nix it will get overwritten.
  hardware = {
    # Enable scanner drivers
    sane = {
      enable = true;
      drivers.scanSnap.enable = true;
    };
    # Enable hardware accelerated graphics drivers
    graphics = {
      enable = true;
    };
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 10; # You should set this so generations are referenced, which avoids them being gc'd
    efi.canTouchEfiVariables = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Power management
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = true;

  # Set your time zone.
  time.timeZone = "America/Mazatlan";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_MX.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "la-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security = {
    # Enable sudo.
    sudo = {
      enable = true;
    };
    # PipeWire (and PulseAudio) use this to acquire realtime priority.
    rtkit = {
      enable = true;
    };
  };

  # Enable sound with PipeWire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      gbm = {
        isNormalUser = true;
        description = "gbm";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        # packages = with pkgs; [
        # ];
        # openssh.authorizedKeys.keys = [
        # ];
      };
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    # https://github.com/nix-community/home-manager/issues/2942
    allowUnfreePredicate = _: true;
  };

  nix = {
    settings = {
      # Optimise nix store during every build
      auto-optimise-store = true;

      # Enable Flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Limit (or not) the number of jobs
      max-jobs = "auto"; # e.g. 8
    };

    # Automate garbage collection
    gc = {
      automatic = true;
      persistent = true;
      # dates = "Sun 14:00";
      dates = "*-*-01 18:00:00";
      randomizedDelaySec = "45min";
      options = "--delete-older-than 7d";
    };
  };

  # I'm commenting this for now until I decide what to do with it.
  # system.autoUpgrade = {
  #   enable = true;
  #   flake = "/etc/nixos/";
  #   # flake = "/home/gbm/nixos/";
  #   # flake = inputs.self.outPath;
  #   persistent = true;
  #   flags = [
  #     "--update-input"
  #     "nixpkgs"
  #     "--print-build-logs" # "-L"
  #   ];
  #   dates = "Sun 16:00";
  #   randomizedDelaySec = "45min";
  #   allowReboot = true;
  #   rebootWindow = {
  #     lower = "16:00";
  #     upper = "19:00";
  #   };
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    bash
    neovim
    wget
    git
    # Emacs compiled using gtk flags
    emacs-pgtk
    flatpak
    gcc
    # Discount is a Markdown implementation
    # discount
    fwupd

    # I'll check later how (if) I want to install these packages
    # postgresql
    # ledger
    # hledger
    # texliveFull
    # python313Full
    # python313Packages.pip
    # rustup
    # jdk
    # beam27Packages.erlang
    # beam27Packages.elixir
    # clojure
    # nodejs_22
    # typescript
    # gnumake
  ];

  # Set the default editor to neovim
  environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  virtualisation = {
    # Enable common container config files in /etc/containers
    containers = {
      enable = true;
    };

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Services:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    # settings = {
    #   # UseDns = true;
    #   # PermitRootLogin = "no";
    #   # PasswordAuthentication = false;
    # };
  };

  # Enable flatpaks
  services.flatpak = {
    enable = true;
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "*-01,04,07,10-01 18:00:00";
    fileSystems = [ "/" ];
  };

  services.emacs = {
    enable = true;
  };

  # Programs:

  # Enable gpg
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # programs.direnv = {
  #   enable = true;
  #   package = pkgs.direnv;
  #   silent = false;
  #   loadInNixShell = true;
  #   direnvrcExtra = "";
  #   nix-direnv = {
  #     enable = true;
  #     package = pkgs.nix-direnv;
  #   };
  # };

  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion

}
