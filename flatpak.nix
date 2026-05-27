{
  config,
  pkgs,
  nix-flatpak,
  ...
}:

{
  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.bitwarden.desktop"
      "com.github.muriloventuroso.pdftricks"
      "com.github.tchx84.Flatseal"
      "com.microsoft.Edge"
      "com.obsproject.Studio"
      "com.valvesoftware.Steam"
      "io.dbeaver.DBeaverCommunity"
      "org.fedoraproject.MediaWriter"
      "org.gimp.GIMP"
      "org.gnome.SimpleScan"
      "org.inkscape.Inkscape"
      "org.kde.kdenlive"
      "org.kde.kontrast"
      "org.kde.krita"
      "org.keepassxc.KeePassXC"
      "org.libreoffice.LibreOffice"
      "org.mozilla.thunderbird_esr"
      "org.onlyoffice.desktopeditors"
      "org.pgadmin.pgadmin4"
      "org.videolan.VLC"
      "org.zealdocs.Zeal"
      # "io.github.hkdb.Aerion"
      # "it.fabiodistasio.AntaresSQL"
    ];
    update.auto = {
      enable = true;
      onCalendar = "Mon 8:00";
    };
    # restartOnFailure = {
    #   enable = true;
    #   restartDelay = "60s";
    #   exponentialBackoff = {
    #     enable = false;
    #     steps = 10;
    #     maxDelay = "1h";
    #   };
    # };
  };
}
