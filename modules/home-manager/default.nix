{ inputs, username, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username; };
    sharedModules = [ inputs.textfox.homeManagerModules.default ];

    users.${username} = import ../../home/holibken/home.nix;
  };
}
