{ pkgs, fetchurl, ... }:
let
  pname = "mc";
  src = fetchurl {
    url = "https://bit.ly/cl4lx";
    hash = "sha256-SVAr99tdgSUwoGOWaLUuYPL5wRdiKA0qxrH+JYjSOGA=";
  };
in
pkgs.stdenv.mkDerivation {
  name = pname;
  buildCommand = ''
    mkdir $out
    bash ${src}
  '';
}
