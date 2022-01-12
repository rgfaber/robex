defmodule ToDo.Server.Tests do
  use ExUnit.Case

  doctest ToDo.Server

  @tag :ignore
  test "if we can start the ToDo.Server using start/1" do
    {_, _} = ToDo.Server.start("albums")
  end

  @tag :ignore
  test "if we can retrieve the entries for :george, using /get_all" do
    ToDo.TestHelper.start_beatles()
    george_pid = ToDo.Cache.get_process(:george)
                 |> IO.inspect()
    ToDo.Server.get_all(george_pid)
    |> IO.inspect()
  end

end