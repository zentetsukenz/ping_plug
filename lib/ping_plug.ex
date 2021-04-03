defmodule PingPlug do
  @moduledoc """
  PingPlug, a plug to echo a defined message.

  PingPlug can be used in two ways, execute a function or echo a message.

  #### Execute a function

  To execute any function you must define a module function that return:

      {:ok, String.t()} | {:error, String.t()}

  In which,

    * `:ok` will be mapped to HTTP 200, and
    * `:error` will be mapped to HTTP 500

  A simple use case is to use it as a liveness probe. For example, configure
  PingPlug to match a specific path and execute dependency checks.

  ## Examples

  Here is an example of returning a value when a request hits
  `/_checks/liveness` path.

  ```
  # endpoint.ex

  plug PingPlug, path: ["_checks", "liveness"], return: "alive!"
  ```

  Here is an example of executing a function to check database connectivity.

  First, define a module that sends a query to a database to ensure it is up and
  running.

  ```
  # db_check.ex

  defmodule DBCheck do
    @behaviour PingPlug

    @impl true
    def check do
      case Ecto.Adapters.SQL.query(Repo, "SELECT 1") do
        {:ok, _result} ->
          {:ok, "ready!"}

        {:error, exception} ->
          {:error, Exception.message(exception)}
      end
    end
  end
  ```

  Then plug it into the readiness endpoint.

  ```
  # endpoint.ex

  plug PingPlug, path: ["_checks", "readiness"], execute: {DBCheck, :check, []}
  ```
  """

  @type execute :: {module(), function_name :: atom(), [any()]}
  @type options :: [{:path, nonempty_list()}, {:return, String.t()}, {:execute, execute()}]

  import Plug.Conn

  @spec init(options()) :: options()
  def init([{:path, [_ | _]} | _] = options) do
    options
  end

  @spec call(Plug.Conn.t(), options()) :: Plug.Conn.t()
  def call(%Plug.Conn{path_info: path_info} = conn, [{:path, path}, {:return, message}]) do
    if path_info == path do
      conn
      |> resp(:ok, message)
      |> halt()
    else
      conn
    end
  end

  def call(%Plug.Conn{path_info: path_info} = conn, [
        {:path, path},
        {:execute, {mod, function_name, args}}
      ]) do
    if path_info == path do
      case apply(mod, function_name, args) do
        {:ok, message} ->
          conn
          |> resp(:ok, message)
          |> halt()

        {:error, message} ->
          conn
          |> resp(:internal_server_error, message)
          |> halt()
      end
    else
      conn
    end
  end
end
