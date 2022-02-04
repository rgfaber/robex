defmodule ToDo.DatabaseWorker.Tests do
  use ExUnit.Case

  doctest ToDo.DatabaseWorker

  @db_folder "./db"
  @tag :ignore
  test "if we can start a ToDo.DatabaseWorker using start/1" do
    ToDo.System.start_link()
    ToDo.DatabaseWorker.start_link({@db_folder, 1})
    |> IO.inspect()
  end







end