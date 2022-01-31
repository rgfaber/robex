defmodule ToDo.System.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.System

#  @tag :ignore
  test "if we can start the system using start_link/0" do
    ToDo.System.start_link()
    pid = ToDo.CacheSupervisor.server_process(:george)
#    Process.exit(Process.whereis(ToDo.DbSupervisor), :kill)
#    IO.puts("pause 1s")
#    Process.sleep(1000)
#    did = Process.whereis(ToDo.DbSupervisor)
#    IO.puts("TooDoo.Database: #{inspect(did)}")
#    Process.exit(Process.whereis(ToDo.Cache), :kill)
#    IO.puts("pause 1s")
#    Process.sleep(1000)
#    cid = Process.whereis(ToDo.Cache)
#    IO.puts("ToDo.Cache: #{inspect(cid)}")
#    _george = ToDo.CacheSupervisor.server_process(:george)
  end

  @tag :ignore
  test "if we can start a Registry" do
    IO.puts("Starting ToDo.Registry")
    Registry.start_link(name: :todo_registry, keys: :unique)
    IO.puts("Spawning and Registering {:db_worker, 1}")
    spawn(
      fn ->
        Registry.register(:todo_registry, {:db_worker, 1}, "I am db worker 1")
        receive do
          msg -> IO.puts("Received Message [#{msg}]")
        end
      end
    )
    
    IO.puts("Discovering the db_worker using Registry.lookup")
    [{db_worker_pid, _opts}] = 
      Registry.lookup(:todo_registry, {:db_worker, 1})
      |> IO. inspect()

    send(db_worker_pid, "Hello there!")
#    
#    [{db_worker_pid, _opts}] =
#      Registry.lookup(:todo_registry, {:db_worker, 1})
#      |> IO. inspect()

  end
  
  
  @tag :ignore
  test "if we can await tasks" do
    # define a query function
    run_query = fn query_def ->
      Process.sleep(2000)
      IO.puts("#{query_def} result")
    end
    # we want 5 queries to run concurrently
    queries = 1..5

    queries
    |> Enum.map(&Task.start_link(fn -> run_query.("start_link...Query #{&1}") end))


    # Run the queries
    _tasks =
    queries
    |> Enum.map(&Task.async(fn -> run_query.("async ..Query #{&1}") end))
    |> Enum.map(&Task.await/1)
    

 
  end
  
  
  







end