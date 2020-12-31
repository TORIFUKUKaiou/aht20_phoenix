defmodule Aht20.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Aht20.Repo,
      # Start the Telemetry supervisor
      Aht20Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Aht20.PubSub},
      # Start the Endpoint (http/https)
      Aht20Web.Endpoint
      # Start a worker by calling: Aht20.Worker.start_link(arg)
      # {Aht20.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Aht20.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Aht20Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
