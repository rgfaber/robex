defmodule Fraction.Tests do
  use ExUnit.Case

  test "Test that we can create a Fraction with struct" do
    assert %Fraction{a: 4, b: 7} != nil
  end

  test "Test that we can create a Fraction with new/2" do
    %Fraction{a: aa, b: bb} = Fraction.new(7, 5)
    assert aa == 7
    assert bb == 5
  end

  test "Test that we can get the value from the Fraction with value/1" do
    assert Fraction.value(%Fraction{a: 4, b: 8}) != nil
  end
  


end