defmodule ToDoGenServer.Tests do
  use ExUnit.Case

  doctest ToDoGenServer

  test "Test if we can start the ToDoGenServer" do
    ToDoGenServer.start()
    |> IO.inspect()
  end


  test "Test if we can put something in the todo list" do
    {_, pid} = ToDoGenServer.start
    ToDoGenServer.put(pid, ~D[1968-10-16], "My Birthday")
    ToDoGenServer.put(pid, ~D[1969-07-21], "First Man on the Moon")
  end


end