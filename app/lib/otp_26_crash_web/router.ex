defmodule Otp26CrashWeb.Router do
  use Otp26CrashWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Otp26CrashWeb do
    pipe_through :api
  end
end
