{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gbm";
  home.homeDirectory = "/home/gbm";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    kdePackages.kate
    kdePackages.kate
    kdePackages.kcalc
    kdePackages.filelight
    # pkgs.kdePackages.plasma-login-manager
    btrfs-assistant
    distrobox
    pandoc
    direnv
    nix-direnv
    unzip
    aspell
    aspellDicts.en
    aspellDicts.es
    tree
    fzf
    hunspell
    hunspellDicts.en_US
    hunspellDicts.es_MX
    yt-dlp

    # I'll see if I install these packages.
    # pkgs.mpv
    # pkgs.fastfetch
    # pkgs.htop
    # pkgs.btop
    # pkgs.iotop
    # pkgs.iftop
    # pkgs.nvtopPackages.full
    # pgks.pgadmin4
    # pgks.thunderbird
    # pkgs.pciutils
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gbm/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  ######################################################################################################################
  ######################################################################################################################
  ######################################################################################################################

  # Programs & Services

  programs.plasma = {
    enable = true;
    overrideConfig = false;

    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      # cursor.theme = "Bibata-Modern-Ice";
      # iconTheme = "Papirus-Dark";
      wallpaper = "${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/ScarletTree/contents/images_dark/5120x2880.png";
    };

    # hotkeys.commands."launch-konsole" = {
    #   name = "Launch Konsole";
    #   key = "Ctrl+Alt+T";
    #   command = "konsole";
    # };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    package = pkgs.direnv;
    silent = false;
    # loadInNixShell = true;
    # direnvrcExtra = "";
    nix-direnv = {
      enable = true;
      # package = pkgs.nix-direnv;
    };
    # https://github.com/direnv/direnv/wiki/Customizing-cache-location#human-readable-directories
    stdlib = ''
      : "''${XDG_CACHE_HOME:="''${HOME}/.cache"}"
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
          local hash path
          echo "''${direnv_layout_dirs[$PWD]:=$(
              hash="''$(sha1sum - <<< "$PWD" | head -c40)"
              path="''${PWD//[^a-zA-Z0-9]/-}"
              echo "''${XDG_CACHE_HOME}/direnv/layouts/''${hash}''${path}"
          )}"
      }
      layout_uv() {
        if [[ -d ".venv" ]]; then
          VIRTUAL_ENV="''$(pwd)/.venv"
        fi

        if [[ -z ''$VIRTUAL_ENV || ! -d ''$VIRTUAL_ENV ]]; then
          if [[ ! -f "pyproject.toml" ]]; then
            log_status "No uv project exists. Executing \`uv init\` to create one."
            uv init --no-readme
            rm main.py
            uv venv
          else
            uv sync
          fi
          VIRTUAL_ENV="''$(pwd)/.venv"
        fi

        if [ -d ".venv/bin" ]; then
          PATH_add .venv/bin
        elif [ -d ".venv/Scripts" ]; then
          PATH_add .venv/Scripts
        fi
        export UV_ACTIVE=1 # or VENV_ACTIVE=1
        export VIRTUAL_ENV
      }
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    package = pkgs.fzf;
  };

}
