defmodule RaptorexLookupV0Test do
  use ExUnit.Case
  alias Raptorex.Lookup.V0

  test "indices" do
    assert V0.value(0) == 251_291_136
    assert V0.value(255) == 1_358_307_511
    assert V0.value(-1) == :error
    assert V0.value(256) == :error
  end
end
