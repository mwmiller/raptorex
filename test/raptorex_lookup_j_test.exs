defmodule RaptorexLookupJTest do
  use ExUnit.Case
  alias Raptorex.Lookup.J

  test "indices" do
    assert J.value(4) == 18
    assert J.value(8192) == 2665
    assert J.value(3) == :error
    assert J.value(8193) == :error
  end
end
