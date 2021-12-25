defmodule ToDo.Tests do
  use ExUnit.Case

  test "Test that we can create a ToDo list" do
    assert is_map(ToDo.new())
  end

  test "Test that we can add items to the ToDo list" do
    to_do()
    |> IO.inspect()
  end

  defp to_do(),
       do:
         ToDo.new()
         |> ToDo.add_entry(
              %{
                date: ~D[2021-12-30],
                title: "Interview"
              }
            )
         |> ToDo.add_entry(
              %{
                date: ~D[2021-12-25],
                title: "Christmas"
              }
            )
         |> ToDo.add_entry(
              %{
                date: ~D[2022-01-01],
                title: "New Year"
              }
            )
         |> ToDo.add_entry(
              %{
                date: ~D[2022-11-01],
                title: "All Saints"
              }
            )
         |> ToDo.add_entry(
              %{
                date: ~D[2021-12-25],
                title: "Sir Isaac's Birthday"
              }
            )


  test "Test that we can retrieve entries from the ToDo list" do
    to_do()
    |> ToDo.entries(~D[2021-12-25])
    |> IO.inspect()
  end

  test "Test that we can update using ToDo.update/3" do
    todo_list = to_do()
    new_entry = %{date: ~D[2021-10-06], title: "Birthday"}
    new_todo = ToDo.update(todo_list, 2, &Map.put(&1, :date, new_entry.date))
    new_todo
    |> IO.inspect()
  end
  
  
  test "Test that we can update using ToDo.update/2" do
    todo_list = to_do()
    new_entry = %{id: 2, date: ~D[2021-10-06], title: "Easter", comment: "not really"}
    new_todo = ToDo.update(todo_list, new_entry)
    |> IO.inspect()
  end


end