# PingPlug

[![Build Status](https://travis-ci.org/zentetsukenz/ping_plug.svg?branch=master)](https://travis-ci.org/zentetsukenz/ping_plug)

A simple Elixir plug to echo message

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

Add `ping_plug` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ping_plug, "~> 0.1.0"}]
end
```

## Usage

Mount PingPlug module to your desire route.

e.g. route.ex

```elixir
get "/ping", PingPlug, []
```

only 2 options are available right now,

- :message is the response that will be echoed back. The default is "pong".
- :content_type is HTTP Header Content type. The default is "text/plain".

e.g.

```elixir
get "/ping", PingPlug, [message: Mix.env]
```
