defmodule Otp26Crash.Broadcast do
  use GenServer

  require Logger

  # Client

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Server (callbacks)

  @impl true
  def init(_) do
    timer = :erlang.send_after(2_000, self(), :send_message)
    {:ok, %{timer: timer}}
  end

  @impl true
  def handle_info(:send_message, state) do
    mb = 1_048_576
    min = 32 * mb
    max = 64 * mb

    data =
      (:rand.uniform(max - min + 1) + min - 1) |> :crypto.strong_rand_bytes() |> Base.encode64()

    :ok = Otp26CrashWeb.Endpoint.broadcast("crash:lobby", "event", %{data: data})

    Logger.info("Broadcast #{byte_size(data)} bytes on WebSocket.")

    timer = :erlang.send_after(2000, self(), :send_message)
    {:noreply, %{state | timer: timer}}
  end
end
