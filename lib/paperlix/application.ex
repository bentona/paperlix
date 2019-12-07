# ./lib/paperlix/application.ex
defmodule Paperlix.Application do
  @moduledoc "OTP Application specification for Paperlix"

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Use Plug.Cowboy.child_spec/3 to register our endpoint as a plug
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Paperlix.Endpoint,
        # Set the port per environment, see ./config/MIX_ENV.exs
        options: [port: Application.get_env(:paperlix, :port)]
      )
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Paperlix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
