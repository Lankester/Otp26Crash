defmodule Otp26Crash.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Otp26CrashWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Otp26Crash.PubSub},
      # Start the Endpoint (http/https)
      Otp26CrashWeb.Endpoint,
      # Start a worker by calling: Otp26Crash.Worker.start_link(arg)
      # {Otp26Crash.Worker, arg}
      Otp26Crash.Broadcast,
      Otp26Crash.SocketClient
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Otp26Crash.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Otp26CrashWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
