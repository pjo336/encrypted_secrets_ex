defmodule Mix.Tasks.EncryptedSecrets.Encrypt do
  use Mix.Task

  def run(args) do
    [filepath | _tail] = args |> Enum.map(&String.trim/1)
    EncryptedSecrets.encrypt(filepath)
  end
end
