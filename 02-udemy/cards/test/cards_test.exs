defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Test that we can create a deck of cards using new/0" do
    assert Cards.new() != nil
  end

end
