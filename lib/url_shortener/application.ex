defmodule Shortener.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    :dets.open_file(:disk_storage, type: :set)

    children = [
      # Start the Telemetry supervisor
      ShortenerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Shortener.PubSub},
      # Start the Endpoint (http/https)
      ShortenerWeb.Endpoint
      # Start a worker by calling: Shortener.Worker.start_link(arg)
      # {Shortener.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shortener.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShortenerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
