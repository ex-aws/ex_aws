defmodule Mix.Tasks.ExAwsUtil do
  @tf_path "test/setup"
  @suffix_file Path.join(@tf_path, "random_suffix")

  def tf_path, do: @tf_path

  def random_suffix do
    case File.read(@suffix_file) do
      {:error, :enoent} ->
        suffix =
          16
          |> :crypto.strong_rand_bytes()
          |> Base.encode32(padding: false, case: :lower)

            :ok = File.write(@suffix_file, suffix)
            suffix
            {:ok, suffix} ->
              suffix
              end
    end
end
