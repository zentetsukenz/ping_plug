defmodule PingPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "return default message as pong" do
    options = PingPlug.init([])
    conn = conn(:get, "/")

    conn = PingPlug.call(conn, options)

    assert "pong" == conn.resp_body
  end

  test "return input message as text" do
    options = PingPlug.init([message: Mix.env])
    conn = conn(:get, "/")

    conn = PingPlug.call(conn, options)

    assert to_string(Mix.env) == conn.resp_body
  end

  test "return default content type as text/plain" do
    options = PingPlug.init([])
    conn = conn(:get, "/")

    conn = PingPlug.call(conn, options)

    assert ["text/plain"] == get_resp_header(conn, "content-type")
  end

  test "return input content type" do
    options = PingPlug.init([content_type: "application/json"])
    conn = conn(:get, "/")

    conn = PingPlug.call(conn, options)

    assert ["application/json"] == get_resp_header(conn, "content-type")
  end
end
