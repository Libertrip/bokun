defmodule Bokun.Mixfile do
  use Mix.Project

  @description """
    A Bokun wrapper for Elixir
    Requires an active account with Bokun (http://bokun.io/).
  """

  def project do
    [app: :bokun,
     version: "0.0.4",
     elixir: "~> 1.2",
     description: @description,
     package: package,
     source_url: "https://github.com/Libertrip/Bokun",
     deps: deps,
     docs: [extras: ["README.md"]]]
  end


  def application do
    [applications: [:logger, :hackney, :poison, :timex],
     mod: {Bokun, []}]
  end

  defp deps do
    [
      {:tesla, "~> 0.5.1"},
      {:poison, "~> 2.2"},
      {:timex, "~> 3.0"},

      # testing & docs
      {:ex_doc, "~> 0.13.1", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Maxime Raverdy"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Libertrip/Bokun"}
    ]
  end
end
