defmodule PingPlug.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ping_plug,
      version: "0.2.1",
      elixir: "~> 1.8",
      deps: deps(),
      package: package(),
      description: description(),
      docs: [
        extras: ~W(README.md)
      ]
    ]
  end

  def application do
    [applications: [:logger, :plug]]
  end

  defp deps do
    [
      {:cowboy, "~> 2.0", optional: true},
      {:plug, "~> 1.7"},
      {:ex_doc, ">= 0.19.1", only: :dev, runtime: false},
      {:dialyxir, ">= 1.0.0-rc4", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Wiwatta  Mongkhonchit"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/zentetsukenz/ping_plug",
        "Docs" => "https://hexdocs.pm/ping_plug"
      }
    ]
  end

  defp description do
    """
    A simple plug to echo message back, useful with healthcheck endpoint
    where you just need to response 200 ok.
    """
  end
end
