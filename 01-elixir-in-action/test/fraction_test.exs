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

  test "Test that we can add 2 Fractions" do
    frac1 = %Fraction{a: 84, b: 2}
    frac2 = %Fraction{a: 49, b: 7}
    Fraction.add(frac1, frac2)
    |> IO.inspect()
  end

  test "Test that we can get the value of the addition" do
    frac1 = %Fraction{a: 84, b: 2}
    frac2 = %Fraction{a: 49, b: 7}
    Fraction.add(frac1, frac2)
    |> Fraction.value()
    |> IO.inspect()
  end



end