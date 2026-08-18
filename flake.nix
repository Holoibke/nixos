{
  description = "Nix Holibkeński";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    textfox.url = "github:adriankarlen/textfox";

    affinity-nix.url = "github:mrshmllow/affinity-nix";

    creamlinux-installer = {
      type = "github";
      owner = "Novattz";
      repo = "creamlinux-installer";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      username = "holibken";
      hostname = "Mieszko-II-Lambert";

      pkgs = import nixpkgs {
	      inherit system;
	      config.allowUnfree = true;
      };

    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };
        modules = [ ./hosts/mieszko-ii-lambert ];
      };

      homeConfigurations."${username}@${hostname}" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs username; };
          modules = [
            inputs.textfox.homeManagerModules.default
            ./home/holibken/home.nix
          ];
        };
    };
}
