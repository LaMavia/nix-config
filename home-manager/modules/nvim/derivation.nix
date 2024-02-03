{ stdenv, ... }:
let
  userConfig = ./config;
in
stdenv.mkDerivation {
  name = "nvim-config";

  src = builtins.fetchGit {
    url = "https://github.com/AstroNvim/AstroNvim.git";
  };
  
  installPhase = ''
    cp -r . $out
    cp -r ${userConfig} $out/lua/user
  '';
}
