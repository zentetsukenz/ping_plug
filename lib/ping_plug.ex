defmodule PingPlug do
  import Plug.Conn

  def defaults do
    [
      message:      "pong",
      content_type: "text/plain",
    ]
  end

  def init(options) do
    defaults
    |> Keyword.merge(options)
    |> sanitize_options()
  end

  def call(%Plug.Conn{} = conn, options) do
    conn
    |> put_resp_content_type(options[:content_type])
    |> send_resp(200, options[:message])
  end

  defp sanitize_options(options) do
    [
      message:      to_string(options[:message]),
      content_type: options[:content_type],
    ]
  end
end
