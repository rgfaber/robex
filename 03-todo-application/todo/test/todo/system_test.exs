defmodule ToDo.System.Tests do
  use ExUnit.Case, async: true
    
  doctest ToDo.System

  test "if we can start the system using start_link/0" do
    ToDo.System.start_link()
    |> IO.inspect()
  end
  
  
  
end