defmodule ToDo.Tests do
  use ExUnit.Case

  test "Test that we can create a ToDo list" do
    assert is_map(ToDo.new())
  end

  test "Test that we can add items to the ToDo list" do
    to_do()
  end

  defp to_do(), 
    do: 
      ToDo.new()
       |> ToDo.add_entry(
            %{
              date: ~D[2021-12-30],
              title: "Interview"
            })
       |> ToDo.add_entry(
            %{
              date: ~D[2021-12-25],
              title: "Christmas"
            })
       |> ToDo.add_entry(
            %{
              date: ~D[2022-01-01],
              title: "New Year"
            })
       |> ToDo.add_entry(
            %{
              date: ~D[2022-11-01],
              title: "All Saints"
            })


  test "Test that we can retrieve entries from the ToDo list" do
    to_do()
    |> ToDo.entries(~D[2021-12-25])
  end


end