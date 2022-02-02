defmodule EtsKeyValue.Tests do
  use ExUnit.Case

  doctest EtsKeyValue


  test "if we can write to the EtsKeyValue table" do
    EtsKeyValue.start_link()
    EtsKeyValue.put(:one, {1, "one"} )
    EtsKeyValue.put(:two, {2, "two"})
    EtsKeyValue.put(:two, {2, "two"})
  end

end