defmodule Raptorex.Generators do
  use Bitwise
  alias Raptorex.Lookup.{J, Primes, V0, V1}

  # the largest prime smaller than 2^^16.
  @q 65521

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

  def triple(k, x) do
    lp = Primes.smallestgte(Raptorex.l(k))
    j = J.value(k)

    a = rem(53591 + j * 997, @q)
    b = rem(10267 * (j + 1), @q)
    y = rem(b + x * a, @q)

    {rand(y, 0, 1_048_576) |> degree(), 1 + rand(y, 1, lp - 1), rand(y, 2, lp)}
  end
end
