defmodule Quadratic.Tests do
  use ExUnit.Case
  doctest Quadratic

  test "all zeroes must return zero" do
    d = Quadratic.d(0, 0, 0)
    assert  d == {:real, 0}
    d
  end

  test ":real for negative a" do
    d = Quadratic.d(-1, 5, 5)
    assert d == {:real, 45}
    d
  end

  test ":imaginary for all positives" do
    d = Quadratic.d(1, 2, 2)
    assert d == {:imaginary, -4}
    d
  end

  test "Real roots from positive discriminator" do
    {stat, _} = Quadratic.roots(-1, 5, 5)
    assert stat == :real
  end




end