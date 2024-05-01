defmodule LocaleRepro.MixProject do
  use Mix.Project

  def project do
    [
      app: :locale_repro,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:deps_nix, "~> 0.2.2", only: :dev},
      {:ex_cldr_currencies, "~> 2.16"},
      {:ex_cldr_dates_times, "~> 2.16"},
      {:jason, "~> 1.4"}
    ]
  end

  defp aliases do
    [
      "deps.get": ["deps.get", "deps.nix"],
      "deps.update": ["deps.update", "deps.nix"]
    ]
  end
end
