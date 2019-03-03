defmodule EncryptedSecrets.MixProject do
  use Mix.Project

  def project do
    [
      app: :encrypted_secrets,
      version: "0.1.0",
      elixir: "~> 1.7",
      description: description(),
      package: package(),
      source_url: "https://github.com/kieraneglin/encrypted_secrets_ex",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.12"},
      {:yaml_elixir, "~> 2.1.0"},
      {:ex_crypto, "~> 0.10.0"}
    ]
  end

  defp description() do
    "A package that allows you to store encrypted application secrets in your VCS"
  end

  defp package() do
    [
      name: "EncryptedSecrets",
      licenses: ["MIT"],
      links: %{repo: "https://github.com/kieraneglin/encrypted_secrets_ex"}
    ]
  end
end
