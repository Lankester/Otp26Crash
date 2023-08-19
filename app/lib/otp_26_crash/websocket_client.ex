defmodule Otp26Crash.SocketClient do
  @moduledoc """
  A socket client for connecting to that other Phoenix server

  Periodically sends pings and asks the other server for its metrics.
  """

  use Slipstream

  require Logger

  @topic "crash:lobby"

  def start_link(_) do
    config = [
      uri: %URI{
        host: "localhost",
        path: "/socket/websocket",
        port: 4000,
        scheme: "ws"
      }
    ]

    Slipstream.start_link(__MODULE__, config, name: __MODULE__)
  end

  @impl Slipstream
  def init(config) do
    {:ok, connect!(config)}
  end

  @impl Slipstream
  def handle_connect(socket) do
    {:ok, join(socket, @topic)}
  end

  @impl Slipstream
  def handle_join(@topic, _join_response, socket) do
    {:ok, socket}
  end

  @impl Slipstream
  def handle_message(@topic, _event, %{"data" => data}, socket) do
    Logger.info("Received message. #{byte_size(data)} bytes.")

    {:ok, socket}
  end

  @impl Slipstream
  def handle_disconnect(_reason, socket) do
    {:stop, :normal, socket}
  end
end
