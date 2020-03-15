defmodule Mix.Tasks.EncryptedSecrets.Decrypt do
  use Mix.Task

  def run(args) do
    EncryptedSecrets.decrypt() do
      :ok -> nil
      {:error, err} -> raise err
    end
  end
end
