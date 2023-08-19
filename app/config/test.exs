import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :otp_26_crash, Otp26CrashWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OS8uOt7KoN6PJK4hq3dn4EVxKmJpsrTMiZvkkLGQT5QzCDXqbS6IpPpgi1Mj16Dj",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
