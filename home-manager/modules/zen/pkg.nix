{ makeDesktopItem, appimageTools, lib, fetchurl, ... }:
let
  pname = "zen-specific";
  version = "1.0.0-a.29";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/${pname}.AppImage";
    hash = "sha256-cB2aJ9awl+gTyBOe0T7wMiZWw7RcwohOuCCdWBJXXwo=";
  };
  appimageContents = appimageTools.extract {
    inherit pname version src;
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
  install -m 444 -D ${appimageContents}/zen.desktop $out/share/applications/zen.desktop
  install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/128x128/apps/zen.png \
    $out/share/icons/hicolor/128x128/apps/zen.png
  substituteInPlace $out/share/applications/zen.desktop \
      --replace 'Exec=zen' 'Exec=${pname}'
  '';

  # desktopItems = [
  #   (makeDesktopItem {
  #     name = pname;
  #     exec = pname;
  #     icon = "zdl3";
  #     desktopName = "ZDL";
  #     genericName = "A ZDoom WAD Launcher";
  #     categories = [ "Game" ];
  #   })
  # ];
}
