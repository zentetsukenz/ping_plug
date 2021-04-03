defmodule PingPlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule PlugBypassReturnTest do
    use Plug.Builder

    plug(PingPlug, path: ["bypass", "me"], return: "someting else")
    plug(:passthrough)

    defp passthrough(conn, _),
      do: Plug.Conn.send_resp(conn, :ok, "little light at the end of the tunnel")
  end

  test "bypasses return value if path does not match" do
    conn = conn(:get, "/does-not-match") |> PlugBypassReturnTest.call([])

    assert 200 == conn.status
    assert "little light at the end of the tunnel" == conn.resp_body
    refute conn.halted
  end

  test "returns defined value if path matched" do
    conn =
      conn(:get, "/_checks/readiness")
      |> PingPlug.call(path: ["_checks", "readiness"], return: "read!")

    assert 200 == conn.status
    assert "read!" == conn.resp_body
    assert conn.halted
  end

  defmodule Check do
    def execute(:success) do
      {:ok, "pass!"}
    end

    def execute(:fail) do
      {:error, "tho shall not pass!"}
    end
  end

  defmodule PlugBypassExecuteTest do
    use Plug.Builder

    plug(PingPlug, path: ["bypass", "me"], execute: {Check, :execute, []})
    plug(:passthrough)

    defp passthrough(conn, _), do: Plug.Conn.send_resp(conn, :ok, "hope, is all we have")
  end

  test "bypasses execution if path does not match" do
    conn = conn(:get, "/does-not-match") |> PlugBypassExecuteTest.call([])

    assert 200 == conn.status
    assert "hope, is all we have" == conn.resp_body
    refute conn.halted
  end

  test "returns http 200 if execution success" do
    conn =
      conn(:get, "/_checks/liveness")
      |> PingPlug.call(path: ["_checks", "liveness"], execute: {Check, :execute, [:success]})

    assert 200 == conn.status
    assert "pass!" == conn.resp_body
    assert conn.halted
  end

  test "returns http 500 if execution fail" do
    conn =
      conn(:get, "/_checks/liveness")
      |> PingPlug.call(path: ["_checks", "liveness"], execute: {Check, :execute, [:fail]})

    assert 500 == conn.status
    assert "tho shall not pass!" == conn.resp_body
    assert conn.halted
  end
end
