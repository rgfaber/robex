defmodule ToDo.Cache.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.Cache


  @tag :ignore
  test "Test if we can get a list of all the ToDo.Servers" do
    # First, we start a new ToDo.Cache and we fill it with the usual suspects
    ToDo.TestHelper.start_beatles()
    ToDo.Cache.fetch_all_servers()
    |> IO.inspect()
  end


  @tag :ignore
  test "Test if we can add an entry to all ToDo Lists using broadcast/3" do
    ToDo.TestHelper.start_beatles()
    ToDo.Cache.fetch_all_servers()
    |> Enum.each(fn {_name, pid} -> ToDo.Server.put(pid, ~D[1958-08-02], "Let's Rock!") end)

    ToDo.Cache.fetch_all_servers()
    |> Stream.filter(fn {name, _pid} -> name != :pete  end)
    |> Enum.each(
         fn {_name, pid} ->
           ToDo.Server.put(pid, ~D[1962-12-15], "Go to Hamburg!")
           ToDo.Server.put(pid, ~D[1963-02-20], "Please Please Me!")
         end
       )

    ringo_pid = ToDo.Cache.get_process(:ringo)
    ToDo.Server.get_all(ringo_pid)
    |> IO.inspect()

    pete_pid = ToDo.Cache.get_process(:pete)
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


  @tag :ignore
  test "if we can start ToDo.Cache from a Supervisor" do
    start_supervisor()
    |> IO.inspect()
  end

  def start_supervisor() do
    IO.puts("Starting the Supervisor")
    Supervisor.start_link( [ToDo.Cache],  strategy: :one_for_one )
  end

  @tag :ignore
  test "if the Supervisor can restart the ToDo.Cache" do
    {_, sup_id} = start_supervisor()
    cache_pid = Process.whereis(ToDo.Cache)
    IO.puts("Killing ToDo.Cache #{inspect(cache_pid)}")
    Process.exit(cache_pid, :kill)
    Process.sleep(1000)
    cache_pid = Process.whereis(ToDo.Cache)
    george = ToDo.Cache.get_process(:george)
             |> IO.inspect()
  end

  @tag :ignore
  test "if we can get :george's process" do
    start_supervisor()
    george = ToDo.Cache.get_process(:george)
             |> IO.inspect()
  end







end