{ beamPackages, callPackages }:

beamPackages.mixRelease {
  pname = "locale-repro";
  version = "0.1.0";
  src = ./.;
  mixNixDeps = callPackages ./deps.nix { };
}
