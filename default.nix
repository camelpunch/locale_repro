{ beamPackages, callPackages }:

beamPackages.mixRelease {
  pname = "locale-repro";
  version = "0.1.0";
  src = ./.;
  mixNixDeps = callPackages ./deps.nix {
    overrides = (final: prev:
      let
        hack = {
          preBuild = ''
            data_dir="$(mix eval --no-compile --no-deps-check "Cldr.Config.cldr_data_dir() |> IO.puts")"
            mkdir -p "$(dirname "$data_dir")"
            ln -sfv ${prev.ex_cldr}/src/priv/cldr "$(dirname "$data_dir")"
          '';
        };
      in
      {
        ex_cldr_calendars = prev.ex_cldr_calendars.override hack;
        ex_cldr_currencies = prev.ex_cldr_currencies.override hack;
        ex_cldr_dates_times = (prev.ex_cldr_dates_times.override hack).override { mixEnv = "dev"; };
        ex_cldr_numbers = prev.ex_cldr_numbers.override hack;
      });
  };
}
