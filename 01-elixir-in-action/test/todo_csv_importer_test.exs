defmodule ToDo.CsvImporter.Test do
  use ExUnit.Case

  doctest ToDo.CsvImporter
 
  test "Test that we can parse a CSV file" do
    ToDo.CsvImporter.read("./todos.csv")
  end
  
end
