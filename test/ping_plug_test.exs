defmodule PingPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "return environment as a text" do
    env = PingPlug.init(:dev)
    conn = conn(:get, "/")

    conn = PingPlug.call(conn, env)

    assert "dev" == conn.resp_body
  end

  test "return content type as text/plain" do
    env = PingPlug.init(:dev)
    conn = conn(:get, "/")

    conn = PingPlug.call(conn, env)

    assert ["text/plain"] == get_resp_header(conn, "content-type")
  end
end
