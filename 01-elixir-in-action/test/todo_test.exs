defmodule ToDo.Tests do
  use ExUnit.Case

  test "Test that we can create a ToDo list" do
    assert is_map(ToDo.new())
  end

  test "Test that we can add items to the ToDo list" do
    ToDo.new()
    |> ToDo.add_entry(~D[2021-12-30], "Interview")
    |> ToDo.add_entry(~D[2021-12-25], "Christmas")
    |> ToDo.add_entry(~D[2022-01-01], "New Year")
    |> ToDo.add_entry(~D[2022-11-01], "All Saints")
  end

  defp to_do(),
       do: ToDo.new()
           |> ToDo.add_entry(~D[2021-12-30], "Interview")
           |> ToDo.add_entry(~D[2021-12-25], "Christmas")
           |> ToDo.add_entry(~D[2022-01-01], "New Year")

  test "Test that we can retrieve entries from the ToDo list" do
    xmas = to_do()
    |> ToDo.entries(~D[2021-12-25])
    assert xmas==["Christmas"]
  end


end