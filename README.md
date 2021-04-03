# PingPlug

[![CI/CD](https://github.com/zentetsukenz/ping_plug/actions/workflows/cicd.yml/badge.svg?branch=master)](https://github.com/zentetsukenz/ping_plug/actions/workflows/cicd.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/ping_plug.svg?logo=elixir)](https://hex.pm/packages/ping_plug)

PingPlug, a plug to echo a defined message.

## Installation

The package can be installed as:

Add `ping_plug` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ping_plug, "~> 1.0.0"}]
end
```

## Usage

Plug the `PingPlug` anywhere in your middleware stack. e.g. In Phoenix application, endpoint.ex

**with return value**

```elixir
defmodule Endpoint do
  # snip

  plug PingPlug, path: ["_checks", "liveness"], return: "alive!"

  # snip
end
```

**with module function execution**

```elixir
defmodule Checks do
  def execute do
    {:ok, "pass!"}
  end
end

defmodule Endpoint do
  # snip

  plug PingPlug, path: ["_checks", "readiness"], execute: {Checks, :execute, []}

  # snip
end
```

For more information, please see [document](https://hexdocs.pm/ping_plug).