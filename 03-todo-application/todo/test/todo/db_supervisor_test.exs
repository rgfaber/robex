defmodule ToDo.DbSupervisor.Tests do
  use ExUnit.Case, aync: true
  
  doctest ToDo.DbSupervisor

  @tag :ignore
  test "if we can start individual ToDo.DatabaseWorker processes" do
    ToDo.System.start_link()
    [{worker_pid, _}] = Registry.lookup(ToDo.ProcessRegistry, {ToDo.DatabaseWorker, 2})
    Process.exit(worker_pid, :kill)
    
  end
  
  
end