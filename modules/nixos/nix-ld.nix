{ pkgs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    libGL
    libglvnd
    freetype
    fontconfig
    alsa-lib
    libpulseaudio
    udev
    vulkan-loader
    libX11
    libXext
    libXrender
    libXi
    libXfixes
    libXcursor
    libXcomposite
    libXdamage
    libXrandr
    pipewire
    gtk3
    glib
    nspr
    nss
    atk
    cups
    dbus
    cairo
    pango
    libgbm
    expat
    libxcb
    libxkbcommon
    fuse
    icu
    dotnet-sdk
    libice
    libsm
  ];
}
