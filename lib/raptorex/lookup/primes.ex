defmodule Raptorex.Lookup.Primes do
  for prime <-
        File.read!(Application.app_dir(:raptorex, "priv/lookup/primes.txt"))
        |> String.split()
        |> Enum.map(&String.to_integer/1) do
    def smallestgte(n) when n <= unquote(prime), do: unquote(prime)
  end

  def smallestgte(_), do: :error
end
