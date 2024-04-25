{ pkgs }:

with pkgs;

mkShell {
  packages = [
    elixir_1_16
    ((pkgs.elixir_ls.override {
      elixir = elixir_1_16;
    }).overrideAttrs
      {
        buildPhase = ''
          runHook preBuild
          mix do compile --no-deps-check, elixir_ls.release2
          runHook postBuild
        '';
      })
  ];
}
