defmodule PingPlug do
  import Plug.Conn

  def init(env) do
    Atom.to_string(env)
  end

  def call(%Plug.Conn{} = conn, env) do
    conn
    |> put_resp_header("content-type", "text/plain")
    |> send_resp(200, env)
  end
end
