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
  
  test "Test if KeyValueStore can handle a call to get/2" do
    {:ok,pid} = KeyValueStore.start(ToDo.CsvImporter.read("todos.csv"))
    |> IO.inspect()
    KeyValueStore.put(pid, ~D[2001-09-18], "Nathalie's Birthday")
    |> IO.inspect()
    KeyValueStore.get(pid, ~D[2001-09-18] )
    |> IO.inspect()
    KeyValueStore.get(pid, ~D[2001-09-11] )
    |> IO.inspect()    
  end
  
  test "Test if we can start a KeyValueStore using a name" do
    {:ok,_} = KeyValueStore.start(%{}, name: :my_store)
    |> IO.inspect()
  end
  
  test "Test if we can put a key/value using put/2" do
    {:ok,_} = KeyValueStore.start(%{})
    |> IO.inspect()
    KeyValueStore.put(~D[1968-10-16], "Happy Birthday, mom!")
    |> IO.inspect()
  end
  
end