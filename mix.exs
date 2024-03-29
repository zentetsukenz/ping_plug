defmodule PingPlug.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ping_plug,
      # Version will be automatically replaced by semantic release upon release.
      version: "0.0.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      package: package(),
      source_url: source_url(),
      homepage_url: homepage_url(),
      aliases: aliases(),
      description: description(),
      test_coverage: [tool: ExCoveralls],
      docs: [
        extras: ~W(README.md)
      ],
      preferred_cli_env: [
        lint: :test,
        coverage: :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_core_path: "priv/plts",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.5", only: [:dev], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: :test},
      {:plug_cowboy, "~> 2.0"}
    ]
  end

  defp package do
    [
      name: "ping_plug",
      maintainers: ["Wiwatta  Mongkhonchit"],
      licenses: ["MIT"],
      links: %{
        "Github" => source_url(),
        "Docs" => homepage_url()
      }
    ]
  end

  defp source_url, do: "https://github.com/zentetsukenz/ping_plug"
  defp homepage_url, do: "https://hexdocs.pm/ping_plug"

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp description do
    """
    A plug to echo a defined message.
    """
  end

  defp aliases do
    [
      lint: ["format --check-formatted", "credo"],
      coverage: ["coveralls.html --raise"]
    ]
  end
end
