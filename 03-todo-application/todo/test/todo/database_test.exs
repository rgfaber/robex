defmodule ToDo.Database.Tests do
  use ExUnit.Case, async: true

  doctest ToDo.Database

  @tag :ignore
  test "if we can start the ToDo.Database" do
    {_, pid} = ToDo.Database.start()
    IO.inspect(pid)
  end

  #  @tag :ignore
  test "if we can store something in the ToDo.Database.store/2" do
    {_, pid} = ToDo.Database.start()
    ToDo.Database.store("albums", %{date: ~D[1963-05-12], title: "Please Please Me"})
    |> IO.inspect()
  end


  @tag :ignore
  test "if we can retrieve the albums using ToDo.Database.get/1" do
    {_, pid} = ToDo.Database.start()
    ToDo.Database.get("albums")
    |> IO.inspect()
  end







end