defmodule Eql.Mixfile do
  use Mix.Project

  def project do
    [
      app: :eql,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Eql, []},
      applications: [:cowboy, :plug, :absinthe, :absinthe_plug]
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.2.2"},
      {:absinthe, "~> 1.1.10"},
      {:absinthe_plug, "~> 1.1"},
      {:mongo, "~> 0.5.4"},
      {:poison, "~> 1.3.0"}
    ]
  end
end
