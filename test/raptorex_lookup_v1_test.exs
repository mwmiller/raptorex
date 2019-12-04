defmodule RaptorexLookupV1Test do
  use ExUnit.Case
  alias Raptorex.Lookup.V1

  test "indices" do
    assert V1.value(0) == 807_385_413
    assert V1.value(255) == 4_135_048_896
    assert V1.value(-1) == :error
    assert V1.value(256) == :error
  end
end
