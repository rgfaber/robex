defmodule ToDo.CsvImporter.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.CsvImporter

  @tag :ignore
  test "Test that we can import a file in a ToDo.List" do
    todos = ToDo.CsvImporter.read("todos.csv")
    todos.entries
    |> IO.inspect()
  end


end