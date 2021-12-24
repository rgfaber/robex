defmodule Streams.Tests do
  use ExUnit.Case

  doctest Streams

  test "Test to return a indexed list with Enum construct" do
    names = ["Jim", "Bob", "Ellen", "Maggie"]
    assert Streams.Simple.with_enum(names) == ["1. Jim", "2. Bob", "3. Ellen", "4. Maggie"]
  end

  test "Test to return an indexed list using the Stream construct" do
    names = ["Jim", "Bob", "Ellen", "Maggie"]
    assert Streams.Simple.with_stream(names) == ["1. Jim", "2. Bob", "3. Ellen", "4. Maggie"]
  end

  test "Test to return a map with positive numbers and their square roots" do
    values = [49, -25, "not me", :me_neither, 25, 9]
    expected = [{49, 7}, {25, 5}, {9, 3}]
    assert Streams.SquareRoot.get_square_roots(values) == expected
  end

end