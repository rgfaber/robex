defmodule ToDo.Item.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.Item

  @tag :ignore
  test "Test if we can create a ToDo.Item using new/3" do
    ToDo.Item.new(2, ~D[2022-01-01], "New Year")
    |> IO.puts()
    #    |> IO.inspect()
  end


end