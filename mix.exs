defmodule PingPlug.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ping_plug,
      version: "0.2.0",
      elixir: "~> 1.4",
      deps: deps(),
      package: package(),
      description: description(),
      docs: [
        extras: ~W(README.md)
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:cowboy, "~> 2.0", optional: true},
     {:plug, "~> 1.3"},
     {:ex_doc, "~> 0.14", only: :dev}]
  end

  defp package do
    [
      maintainers: ["Wiwatta  Mongkhonchit"],
      licenses: ["MIT"],
      links: %{
        "Github" => "https://github.com/zentetsukenz/ping_plug",
        "Docs"   => "https://hexdocs.pm/ping_plug"
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
