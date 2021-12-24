defmodule Geometry.Tests do
  use ExUnit.Case

  doctest Robex.Geometry


  test "area of circle" do
    assert Robex.Geometry.area({:circle, 1}) == {:circle, 3.14}
  end


  test "area of unknown" do
    assert Robex.Geometry.area(:unknown) == {:error, {:unknown_shape, :unknown}}
  end

end