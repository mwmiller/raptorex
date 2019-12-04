defmodule Raptorex.Generators do
  use Bitwise
  alias Raptorex.Lookup.{V0, V1}

  def rand(x, i, m),
    do: rem(V0.value(rem(x + i, 256)) ^^^ V1.value(rem(trunc(x / 256) + i, 256)), m)
end
