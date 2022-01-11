defmodule ToDo.Cache.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.Cache

  @tag :ignore
  test "Test if we can create a ToDo.Cache Process" do
    ToDo.Cache.start()
    |> IO.inspect()
  end

  @tag :ignore
  test "Test if we can retrieve a process Id for a certain todo_list_name" do
    {_, pid} = ToDo.Cache.start()
    res = ToDo.Cache.get_process(pid, "johns_list")
    IO.puts("John   : \t #{:erlang.pid_to_list(res)}")
    res = ToDo.Cache.get_process(pid, "georges_list")
    IO.puts("George : \t #{:erlang.pid_to_list(res)}")
    res = ToDo.Cache.get_process(pid, "ringos_list")
    IO.puts("Ringo  : \t #{:erlang.pid_to_list(res)}")
    res = ToDo.Cache.get_process(pid, "pauls_list")
    IO.puts("Paul   : \t #{:erlang.pid_to_list(res)}")
  end

  @tag :ignore
  test "Test if we can get a list of all the ToDo.Servers" do
    # First, we start a new ToDo.Cache and we fill it with the usual suspects
    {_, cache_id} = ToDo.TestHelper.start_beatles()
    ToDo.Cache.fetch_all_servers(cache_id)
    |> IO.inspect()
  end


  @tag :ignore
  test "Test if we can add an entry to all ToDo Lists using broadcast/3" do
    {_, cache_id} = ToDo.TestHelper.start_beatles()
    ToDo.Cache.fetch_all_servers(cache_id)
    |> Enum.each(fn {_name, pid} -> ToDo.Server.put(pid, ~D[1958-08-02], "Let's Rock!") end)

    ToDo.Cache.fetch_all_servers(cache_id)
    |> Stream.filter(fn {name, _pid} -> name != :pete  end)
    |> Enum.each(
         fn {_name, pid} ->
           ToDo.Server.put(pid, ~D[1962-12-15], "Go to Hamburg!")
           ToDo.Server.put(pid, ~D[1963-02-20], "Please Please Me!")
         end
       )

    ringo_pid = ToDo.Cache.get_process(cache_id, :ringo)
    ToDo.Server.get_all(ringo_pid)
    |> IO.inspect()

    pete_pid = ToDo.Cache.get_process(cache_id, :pete)
    ToDo.Server.get_all(pete_pid)
    |> IO.inspect()
  end



  #  @tag :ignore
  #  test "if we can start 100_000 ToDo Servers" do
  #    :erlang.system_info(:process_count)
  #    |> IO.inspect()
  #    {_, cache_id} = ToDo.Cache.start
  #    1..100_000
  #    |>  Enum.each(&ToDo.Cache.get_process(cache_id, "todo-list ##{&1}"))
  #    :erlang.system_info(:process_count)
  #    |> IO.inspect()
  #  end








end