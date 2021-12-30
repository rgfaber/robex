defmodule KeyValueStore.Tests do
  use ExUnit.Case
  
  doctest KeyValueStore
  
  test "Test if we can get the KeyValueStore info" do
    KeyValueStore.__info__(:functions)
    |> IO.inspect()
  end
  
  test "Test if we can start the KeyValueStore" do
    KeyValueStore.start(ToDo.CsvImporter.read("todos.csv"))
    |> IO.inspect()
  end 
  
  test "Test if we KeyValueStore can handle a call to :get" do
    {:ok,pid} = KeyValueStore.start(ToDo.CsvImporter.read("todos.csv"))
    |> IO.inspect()
    KeyValueStore.put(pid, ~D[2001-09-18], "Nathalie's Birthday")
    |> IO.inspect()
    KeyValueStore.get(pid, ~D[2001-09-18] )
    |> IO.inspect()
  end
  
  
end