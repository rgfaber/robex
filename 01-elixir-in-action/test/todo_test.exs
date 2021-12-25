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


  test "Test that we can retrieve entries from the ToDo list by date" do
    to_do()
    |> ToDo.entries(~D[2021-12-25])
    #    |> IO.inspect()
  end

  test "Test that we can update using ToDo.update/3" do
    todo_list = to_do()
    new_entry = %{date: ~D[2021-10-06], title: "Birthday"}
    ToDo.update(todo_list, 2, &Map.put(&1, :date, new_entry.date))
    #    new_todo
    #    |> IO.inspect()
  end


  test "Test that we can update using ToDo.update/2" do
    todo_list = to_do()
    new_entry = %{id: 2, date: ~D[2021-10-06], title: "Easter"}
    #    new_todo = put_in(todo_list[2], new_entry)
    _new_todo = ToDo.update(todo_list, new_entry)
    #    |> IO.inspect()
  end

  test "Test that we can delete an entry using delete/2" do
    todo_list = to_do()
    del_entry = %{id: 3}
    _new_todo = ToDo.delete(todo_list, del_entry)
  end

  test "Test that we can build a ToDo list using new/1" do
    entries = [
      %{date: ~D[2007-08-15], title: "Charles"}, 
      %{date: ~D[1987-01-01], title: "Joe"},
      %{date: ~D[1968-10-07], title: "Suzan"},
    ]
    todo_list = ToDo.new(entries)
    todo_list 
    |> IO.inspect()
    assert todo_list != nil
  end
  
  test "Test that we can use ToDo as Collectable" do
    todos = [%{date: ~D[2018-12-19], title: "Dentist"},
    %{date: ~D[2018-12-20], title: "Shopping"},
    %{date: ~D[2018-12-19], title: "Movies"}]
    for entry <- todos, into: ToDo.new(), do: entry
  end


end