{ config, pkgs, nix-flatpak, ... }:

{
  services.flatpak = {
    enable = true;
    remotes = [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];
    packages = [
      "com.bitwarden.desktop"
      "com.github.muriloventuroso.pdftricks"
      "com.github.tchx84.Flatseal"
      "com.microsoft.Edge"
      "com.obsproject.Studio"
      "org.gimp.GIMP"
      "org.gnome.SimpleScan"
      "org.inkscape.Inkscape"
      "org.kde.kdenlive"
      "org.kde.krita"
      "org.libreoffice.LibreOffice"
      "org.mozilla.Thunderbird"
      "org.onlyoffice.desktopeditors"
      "org.videolan.VLC"
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
