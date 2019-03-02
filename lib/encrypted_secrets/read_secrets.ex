defmodule EncryptedSecrets.ReadSecrets do
  def read_into_map(key, input_path) do
    read_encrypted_file(input_path)
    |> unencrypt_file_contents(key)
    |> parse_yaml()
  end

  def read_into_file(key, input_path) do
    read_encrypted_file(input_path)
    |> unencrypt_file_contents(key)
    |> write_temp_file(input_path)
  end

  defp read_encrypted_file(input_path) do
    case File.read(input_path) do
      {:ok, contents} -> contents
      {:error, err} -> throw("Error reading '#{input_path}' (#{err})")
    end
  end

  defp unencrypt_file_contents(input_text, key) do
    [init_vec, cipher_text] =
      String.split(input_text, "|")
      |> Enum.map(&Base.url_decode64!/1)

    case ExCrypto.decrypt(Base.url_decode64!(key), init_vec, cipher_text) do
      {:ok, contents} -> contents
      {:error, err} -> throw("Error decrypting secrets (#{err})")
    end
  end

  defp parse_yaml(yaml_string) do
    YamlElixir.read_from_string(yaml_string)
  end

  defp write_temp_file(yaml_string, input_path) do
    working_directory = Path.dirname(input_path)
    # Honestly, I'm not sure why Rails appends a random string to the tmp files.
    # Maybe to avoid file collisions in a really dumb way?  Who knows.  Anyway, I'm doing it
    random_file_suffix = :crypto.strong_rand_bytes(8) |> Base.encode16()
    filename = "#{working_directory}/secrets_tmp_#{random_file_suffix}.yml"

    case File.write(filename, yaml_string) do
      :ok -> {:ok, filename}
      {:error, err} -> throw("Error creating tempfile (#{err})")
    end
  end
end