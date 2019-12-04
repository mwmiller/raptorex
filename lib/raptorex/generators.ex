defmodule Raptorex.Generators do
  use Bitwise
  alias Raptorex.Lookup.{V0, V1}

  def rand(x, i, m),
    do: rem(V0.value(rem(x + i, 256)) ^^^ V1.value(rem(trunc(x / 256) + i, 256)), m)

  def degree(n) when n < 10241, do: 1
  def degree(n) when n < 491_582, do: 2
  def degree(n) when n < 712_794, do: 3
  def degree(n) when n < 831_695, do: 4
  def degree(n) when n < 948_446, do: 10
  def degree(n) when n < 1_032_189, do: 11
  def degree(n) when n < 1_048_576, do: 40
  def degree(_), do: :error
end
