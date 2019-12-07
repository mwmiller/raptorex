defmodule Raptorex do
  @moduledoc """
  Documentation for Raptorex.
  """

  alias Raptorex.Lookup.Primes

  def x(k), do: intceil((:math.sqrt(8 * k + 1) + 1) / 2)
  def s(k), do: Primes.smallestgte(intceil(0.01 * k) + x(k))
  def h(k), do: find_h(2, k + s(k))
  def l(k), do: k + h(k) + s(k)

  # This search can be better, but I need some bounds
  # to know where to search
  defp find_h(n, sum) do
    case choose(n, intceil(n / 2)) >= sum do
      true -> n
      false -> find_h(n + 1, sum)
    end
  end

  def partition(i, j) do
    ratio = i / j
    il = intceil(ratio)
    is = intfloor(ratio)
    jl = i - is * j
    js = j - jl

    {il, is, jl, js}
  end

  defp intceil(x), do: x |> Float.ceil() |> trunc
  defp intfloor(x), do: x |> trunc
  defp choose(n, k), do: div(fac(n), fac(k) * fac(n - k))

  defp fac(1), do: 1
  defp fac(n), do: fac(n, n - 1)
  defp fac(n, 1), do: n
  defp fac(n, i), do: fac(n * i, i - 1)
end
