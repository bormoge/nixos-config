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
      "com.valvesoftware.Steam"
      "io.dbeaver.DBeaverCommunity"
      "org.fedoraproject.MediaWriter"
      "org.gimp.GIMP"
      "org.gnome.SimpleScan"
      "org.inkscape.Inkscape"
      "org.kde.kdenlive"
      "org.kde.kontrast"
      "org.kde.krita"
      "org.kde.kweather"
      "org.mozilla.thunderbird_esr"
      "org.pgadmin.pgadmin4"
      "org.videolan.VLC"
      "org.zealdocs.Zeal"
      # "com.ktechpit.whatsie"
      # "com.obsproject.Studio"
      # "com.rtosta.zapzap"
      # "io.github.hkdb.Aerion"
      # "io.missioncenter.MissionCenter"
      # "it.fabiodistasio.AntaresSQL"
      # "org.libreoffice.LibreOffice"
      # "org.onlyoffice.desktopeditors"
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
