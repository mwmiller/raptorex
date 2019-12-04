defmodule Raptorex.Lookup.J do
  for {value, index} <-
        File.read!(Application.app_dir(:raptorex, "priv/lookup/j.txt"))
        |> String.split()
        |> Enum.map(&String.to_integer/1)
        |> Enum.zip(4..8192) do
    def value(unquote(index)), do: unquote(value)
  end

  def value(_), do: :error
end
