{ fetchurl, ... }:
let
  pname = "mc";

  src = fetchurl {
    url = "https://bit.ly/cl4lx";
    hash = "sha256-49502bf7db5d812530a0639668b52e60f2f9c11762280d2ac6b1fe2588d23860";
  };
in
derivation {
  name = pname;
  system = "x86_64-linux";
  builder = src;
}
