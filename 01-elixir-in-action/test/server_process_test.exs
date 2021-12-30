defmodule ServerProcess.Tests do
  use ExUnit.Case

  @moduledoc """
  Tests for the ServerProcess -Elixir in Action p161
  """
  doctest ServerProcess

  test "Test that we can start the ServerProcess" do
    pid = ServerProcess.start(KVStore)
    |> IO.inspect()
    assert pid != nil
  end

  @doc """
  Please note: this test uses 'server side functions (callbacks)'
  """
  test "Test if we can put and get values from the KVStore" do
    pid = ServerProcess.start(KVStore)
    ServerProcess.cast(pid, {:put, "name", "raf"})
    |> IO.inspect()
    ServerProcess.call(pid, {:get, "name"})
    |> IO.inspect()
  end
  
  test "Test if we can get/put using the interface functions start/0, get/2, put/3" do
    pid = KVStore.start()
    KVStore.put(pid, :name, "Raf")
    |> IO.inspect()
    KVStore.put(pid, :address, "Gniezno")
    |> IO.inspect()
    KVStore.get(pid, :name)
    |> IO.inspect()
    KVStore.get(pid, :address)
    |> IO.inspect()    
  end
  
  
  
  

end

