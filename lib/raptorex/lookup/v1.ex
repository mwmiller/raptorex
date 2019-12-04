defmodule Raptorex.Lookup.V1 do
  for {value, index} <-
        File.read!(Application.app_dir(:raptorex, "priv/lookup/v1.txt"))
        |> String.split()
        |> Enum.map(&String.to_integer/1)
        |> Enum.zip(0..255) do
    def value(unquote(index)), do: unquote(value)
  end

  def value(_), do: :error
end
