defmodule Heb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HebWeb.Telemetry,
      Heb.Repo,
      {DNSCluster, query: Application.get_env(:heb, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Heb.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Heb.Finch},
      # Start a worker by calling: Heb.Worker.start_link(arg)
      # {Heb.Worker, arg},
      # Start to serve requests, typically the last entry
      HebWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Heb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
