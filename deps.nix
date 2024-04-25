{ lib, beamPackages, overrides ? (x: y: { }) }:

let
  buildMix = lib.makeOverridable beamPackages.buildMix;
  buildRebar3 = lib.makeOverridable beamPackages.buildRebar3;

  self = packages // (overrides self packages);

  packages = with beamPackages; with self; {
    cldr_utils =
      let
        version = "2.25.0";
      in
      buildMix {
        inherit version;
        name = "cldr_utils";

        src = fetchHex {
          inherit version;
          pkg = "cldr_utils";
          sha256 = "9041660356ffa1129e0d87d110e188f5da0e0bba94fb915e11275e04ace066e1";
        };

        beamDeps = [ decimal ];
      };

    decimal =
      let
        version = "2.1.1";
      in
      buildMix {
        inherit version;
        name = "decimal";

        src = fetchHex {
          inherit version;
          pkg = "decimal";
          sha256 = "53cfe5f497ed0e7771ae1a475575603d77425099ba5faef9394932b35020ffcc";
        };
      };

    ex_cldr =
      let
        version = "2.38.0";
      in
      buildMix {
        inherit version;
        name = "ex_cldr";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr";
          sha256 = "8758000c97bdf4b2583c3fedd7cfa35896567a7f8351248b2faa33ba73841cc7";
        };

        beamDeps = [ cldr_utils decimal jason ];
      };

    ex_cldr_currencies =
      let
        version = "2.16.1";
      in
      buildMix {
        inherit version;
        name = "ex_cldr_currencies";

        src = fetchHex {
          inherit version;
          pkg = "ex_cldr_currencies";
          sha256 = "095d5e973bf0ee066dd1153990d10cb6fa6d8ff0e028295bdce7a7821c70a0e4";
        };

        beamDeps = [ ex_cldr jason ];
      };

    jason =
      let
        version = "1.4.1";
      in
      buildMix {
        inherit version;
        name = "jason";

        src = fetchHex {
          inherit version;
          pkg = "jason";
          sha256 = "fbb01ecdfd565b56261302f7e1fcc27c4fb8f32d56eab74db621fc154604a7a1";
        };

        beamDeps = [ decimal ];
      };
  };
in
self
