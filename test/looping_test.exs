defmodule Looping.Tests do
  use ExUnit.Case


  test "Sum of an empty list must return 0 - naive" do
    assert Looping.Sum.sum_of([]) == 0
  end


  test "Calculate the sum of a list of numbers [15,22,5] must return 42 -naive" do
    assert Looping.Sum.sum_of([15,22,5]) == 42
  end
  
  test "Calculate tail-recursive sum of empty list" do
    assert Looping.Sum.tail_recursive_sum_of([]) == 0
  end
  
  test "Calculate tail recursive sum of [15,22,5] -> 42" do
    assert Looping.Sum.tail_recursive_sum_of([15,22,5]) == 42
  end
  
  
  
  
  
end