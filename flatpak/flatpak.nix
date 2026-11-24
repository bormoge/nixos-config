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
      "org.kde.krita"
      "org.mozilla.thunderbird_esr"
      "org.pgadmin.pgadmin4"
      "org.videolan.VLC"
      "org.zealdocs.Zeal"
      # "com.ktechpit.whatsie"
      # "com.rtosta.zapzap"
      # "engineer.atlas.Nyxt"
      # "io.github.hkdb.Aerion"
      # "io.github.peazip.PeaZip"
      # "io.missioncenter.MissionCenter"
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
