defmodule Bokun.Mixfile do
  use Mix.Project

  @description """
    A Bokun wrapper for Elixir
    Requires an active account with Bokun (http://bokun.io/).
  """

  def project do
    [app: :bokun,
     version: "0.0.1",
     elixir: "~> 1.2",
     description: @description,
     deps: deps]
  end


  def application do
    [applications: [:logger, :hackney, :poison, :timex],
     mod: {Bokun, []}]
  end

  defp deps do
    [
      {:tesla, "~> 0.5.1"},
      {:poison, "~> 2.2"},
      {:timex, "~> 3.0"}
    ]
  end
end
