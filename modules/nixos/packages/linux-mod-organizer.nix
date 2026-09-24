{ lib, pkgs, inputs, ... }:

pkgs.rustPlatform.buildRustPackage {
  pname = "linux-mod-organizer";
  version = "1.28.0";

  src = inputs.linux-mod-organizer;

  cargoLock.lockFile = "${inputs.linux-mod-organizer}/Cargo.lock";

  cargoBuildFlags = [ "--bin" "lmo" ];

  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ openssl sqlite ];

  doCheck = false;

  meta = with lib; {
    description = "Native Linux mod organizer for Bethesda games using OverlayFS, inspired by Mod Organizer 2";
    homepage = "https://codeberg.org/enoki/linux-mod-organizer";
    license = licenses.gpl3Plus;
    mainProgram = "lmo";
    platforms = platforms.linux;
  };
}