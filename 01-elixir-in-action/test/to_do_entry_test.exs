defmodule ToDoEntry.Test do
  use ExUnit.Case

  @moduledoc false

  test "Test that we can create a new ToDoEntry using new/0" do
    entry = ToDoEntry.new()
    assert entry != nil
    IO.inspect(entry)
  end

  test "Test that we can create a new ToDoEntry using new/2" do
    entry = ToDoEntry.new(~D[2011-08-15], "Garage")
    assert entry == %ToDoEntry{date: ~D[2011-08-15], title: "Garage"}
    IO.inspect(entry)
  end

end
