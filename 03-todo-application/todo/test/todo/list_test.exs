defmodule ToDo.List.Tests do
  use ExUnit.Case, async: true
  
  doctest ToDo.List
  
  @tag :ignore
  test "Test if we can create a ToDo.List" do
    ToDo.List.new()
    |> IO.inspect()
  end

  @tag :ignore
  test "Test if we can add an Item to the ToDo.List" do
    ToDo.List.new()
    |> ToDo.List.add_entry(%ToDo.Item{date: ~D[2022-01-06], title: "Epiphany"})
    |> IO.inspect()
  end
  
  
  
  
end