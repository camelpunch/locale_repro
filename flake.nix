{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = generate: nixpkgs.lib.genAttrs [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ]
        (system: generate (
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            inherit pkgs;
            callPackage = pkgs.callPackage;
          }
        ));
    in

    {
      packages = forAllSystems ({ callPackage, ... }: {
        default = callPackage ./. { };
      });

      devShells = forAllSystems ({ callPackage, ... }: {
        default = callPackage ./shell.nix { };
      });
    };
}
