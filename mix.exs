defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Issues",
      source_url: "https://github.com/w40141/issues_elixir",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :httpoison, "~> 1.8.0" },
      { :poison, "~> 5.0.0" },
      { :ex_doc, "~> 0.24", only: :dev, runtime: false },
      { :earmark, "~> 1.4.15" },
    ]
  end

  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end

end
