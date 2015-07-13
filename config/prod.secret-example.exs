use Mix.Config

config :vim_sessions, VimSessions.Endpoint,
  secret_key_base: "<replace me>"

config :vim_sessions, VimSessions.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "<replace me>",
  password: "<replace me>",
  database: "vim_sessions_prod",
  size: 20 # The amount of database connections in the pool
