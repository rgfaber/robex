defmodule ProcessPlayground.Test do
  use ExUnit.Case
  
  @moduledoc """
  This module constains all kinds of process toys
  """

#  test "Test if we can start 10 sleepers synchronously" do
#    Enum.map(1..10, &ProcessPlayground.sleeper(&1))    
#  end
  
  
  test "Test if we can spawn 25 processes asynchronously" do
    Enum.each(1..25, &ProcessPlayground.spawn_sleeper(&1))
  end
  
  
end