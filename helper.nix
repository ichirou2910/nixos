inputs:
let
  homeManagerCfg = userPackages: extraImports: {
    home-manager.useGlobalPkgs = false;
    home-manager.extraSpecialArgs = {
      inherit inputs;
    };
    home-manager.users.ichirou.imports = [
      inputs.agenix.homeManagerModules.default
      inputs.nix-index-database.hmModules.nix-index
      ./users/ichirou/dots.nix
    ] ++ extraImports;
    home-manager.backupFileExtension = "bak";
    home-manager.useUserPackages = userPackages;
    home-manager.sharedModules = [
      inputs.plasma-manager.homeManagerModules.plasma-manager
    ];
  };
in
{
  mkMerge = inputs.nixpkgs.lib.lists.foldl' (
    a: b: inputs.nixpkgs.lib.attrsets.recursiveUpdate a b
  ) { };

  mkNixos = machineHostname: nixpkgsVersion: extraModules: extraHmModules: rec {
    nixosConfigurations.${machineHostname} = nixpkgsVersion.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        vars = import ./hosts/vars.nix;
      };
      modules = [
        ./hosts/common
        ./hosts/${machineHostname}
        ./users/ichirou
        inputs.agenix.nixosModules.default
        inputs.home-manager.nixosModules.home-manager
        (inputs.nixpkgs.lib.attrsets.recursiveUpdate (homeManagerCfg false extraHmModules) {
          home-manager.users.ichirou.home.homeDirectory =
            inputs.nixpkgs.lib.mkForce "/home/ichirou";
        })
      ] ++ extraModules;
    };
  };
}
