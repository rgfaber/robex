defmodule Quadratic.Tests do
  use ExUnit.Case
  doctest Quadratic

  test "all zeroes must return zero" do
    assert Quadratic.discriminator(0,0,0) == {:real, 0}    
  end
  
  test ":real for negative a"
  res = {:real, 45} 
  assert Quadratic.discriminator(-1,5,5) == res
  res
end