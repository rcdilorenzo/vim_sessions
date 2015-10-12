defmodule VimSessions.Mixfile do
  use Mix.Project

  def project do
    [app: :vim_sessions,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {VimSessions, []},
     applications: [:phoenix, :phoenix_html, :cowboy, :logger,
                    :phoenix_ecto, :postgrex, :earmark]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ~w(lib web factories test/support)
  defp elixirc_paths(:dev), do: ~w(lib web factories tasks test/support)
  defp elixirc_paths(_),     do: ~w(lib web)

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 1.0.0"},
      {:phoenix_ecto, "~> 0.5"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 1.1"},
      {:phoenix_live_reload, "~> 1.0.1", only: :dev},
      {:cowboy, "~> 1.0"},
      {:faker, github: "igas/faker"},
      {:addict, "~> 0.0.5"},
      {:earmark, "~> 0.1.17"}
    ]
  end
end
