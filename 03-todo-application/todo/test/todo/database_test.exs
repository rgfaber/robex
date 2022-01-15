defmodule ToDo.Database.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.Database


  @tag :ignore
  test "if we can create a pool of workers" do
    ToDo.Database.create_pool()
    |> Enum.to_list()
    |> IO.inspect()
  end

  @tag :ignore
  test "if we can choose a worker called :george" do
    ToDo.System.start_link()
    ToDo.Database.choose_worker(:george)
    |> IO.inspect()
  end


  @tag :ignore
  test "if we can store something in the ToDo.Database.store/2" do
    ToDo.System.start_link()
    ToDo.Database.store(:albums, %{date: ~D[1963-05-12], title: "Please Please Me"})
    |> IO.inspect()
  end


  @tag :ignore
  test "if we can retrieve the albums using ToDo.Database.get/1" do
    ToDo.System.start_link()
    ToDo.Database.get(:albums)
    |> IO.inspect()
  end








end