defmodule Raptorex do
  @moduledoc """
  Documentation for Raptorex.
  """

  alias Raptorex.Lookup.Primes

  # RFC recommended/required values
  @al 4
  @gmax 10
  @kmin 1_024
  @kmax 8_192

  def x(k), do: intceil((:math.sqrt(8 * k + 1) + 1) / 2)
  def s(k), do: Primes.smallestgte(intceil(0.01 * k) + x(k))
  def h(k), do: find_h(2, k + s(k))
  def l(k), do: k + h(k) + s(k)

  # We can someday make this tunable, I guess
  def transport_parameters(_, _, p) when rem(p, @al) != 0, do: :error

  def transport_parameters(f, w, p) do
    g = Enum.min([intceil(p * @kmin / f), p / @al, @gmax])
    t = intfloor(p / (@al * g)) * @al
    kt = intceil(f / t)
    z = intceil(kt / @kmax)
    n = Enum.min([intceil(intceil(kt / z) * t / w), div(t, @al)])
    {t, z, n}
  end

  def block_sizing(f, w, p), do: block_sizing(f, transport_parameters(f, w, p))

  def block_sizing(f, {t, z, n}) do
    kt = intceil(f / t)
    block_info = partition(kt, z) |> count_size(t)
    subblock_info = partition(div(t, @al), n) |> count_size(@al)
    {block_info, subblock_info}
  end

  defp count_size({fl, fs, sl, ss}, size), do: {sl, fl * size, ss, fs * size}

  # This search can be better, but I need some bounds
  # to know where to search
  defp find_h(n, sum) do
    case choose(n, intceil(n / 2)) >= sum do
      true -> n
      false -> find_h(n + 1, sum)
    end
  end

  defp partition(i, j) do
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
