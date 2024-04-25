{ lib, beamPackages, overrides ? (x: y: { }) }:

let
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; { };
in
self
