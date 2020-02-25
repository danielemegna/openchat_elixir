defmodule OpenchatElixirWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :openchat_elixir

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_openchat_elixir_key",
    signing_salt: "aj4eaRq1"

  plug OpenchatElixirWeb.Router
end
