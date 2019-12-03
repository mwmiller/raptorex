defmodule RaptorexLookupPrimesTest do
  use ExUnit.Case
  alias Raptorex.Lookup.Primes

  test "well known values" do
    assert Primes.smallestgte(2) == 2
    assert Primes.smallestgte(3) == 3
    assert Primes.smallestgte(4) == 5
  end

  test "dumb values" do
    assert Primes.smallestgte(-1) == 2
    assert Primes.smallestgte(nil) == :error
    assert Primes.smallestgte(100_000) == :error
  end
end
