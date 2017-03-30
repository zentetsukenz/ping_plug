# PingPlug

[![Build Status](https://travis-ci.org/zentetsukenz/ping_plug.svg?branch=master)](https://travis-ci.org/zentetsukenz/ping_plug)

A simple Elixir plug to echo message

## Installation

The package can be installed as:

Add `ping_plug` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ping_plug, "~> 0.1.0"}]
end
```

For Phoenix 1.3+, please use `~> 0.2.0`

```elixir
def deps do
  [{:ping_plug, "~> 0.2.0"}]
end
```

## Usage

Mount PingPlug module to your desire route.

e.g. route.ex

```elixir
get "/ping", PingPlug, []
```

Add `:ping_plug` to your application dependencies.

mix.exs
```elixir
def application do
  [mod: {MyApp, []},
   applications: [..., :ping_plug, ...]]
end
```

Echo message can be specified by passing an optional params to PingPlug.

e.g.

```elixir
get "/ping", PingPlug, [message: Mix.env]
```

## Available options

- `:message`, Echo message.
- `:content_type`, Response content type.
