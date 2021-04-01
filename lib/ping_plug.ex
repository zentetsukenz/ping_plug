defmodule PingPlug do
  @moduledoc """
  A PingPlug module to echo defined message back.
  """

  import Plug.Conn

  @defaults [
    message: "pong",
    content_type: "text/plain"
  ]

  @spec init(Keyword.t()) :: Keyword.t()
  def init(options) do
    @defaults
    |> Keyword.merge(options)
    |> sanitize_options()
  end

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t() | no_return
  def call(%Plug.Conn{} = conn, options) do
    conn
    |> put_resp_content_type(options[:content_type])
    |> send_resp(200, options[:message])
  end

  defp sanitize_options(options) do
    [
      message: to_string(options[:message]),
      content_type: options[:content_type]
    ]
  end
end
