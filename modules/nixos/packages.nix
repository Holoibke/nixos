{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Core
    git
    wget
    curl
    btop
    neovim
    fastfetch
    tree
    zip
    unzip
    unrar
    mc
    yazi

    # Wayland utilities
    wl-clipboard
    wlr-randr
    grim
    slurp
    mako
    libnotify
    matugen
    hyprpaper
    hypridle
    hyprlock
    hyprshot

    # Theme
    bibata-cursors
    papirus-icon-theme

    # Applications
    firefox
    kdePackages.gwenview
    haruna
    pywalfox-native
    vscodium.fhs

    # Dolphin + KIO
    kdePackages.dolphin
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kio-admin
    kdePackages.qtwayland
    kdePackages.plasma-integration
    kdePackages.kdegraphics-thumbnailers
    kdePackages.breeze-icons
    kdePackages.qtsvg
    kdePackages.kservice
    shared-mime-info
  ];

# Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    jetbrains-mono
    font-awesome
  ];

  programs.appimage = {
    enable = true;
    binfmt = true;
    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: with pkgs; [
        icu
        libxcrypt-legacy
        zlib
      ];
    };
  };
}
