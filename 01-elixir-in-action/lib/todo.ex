defmodule ToDo do
  def new(), do: %{}
  def add_entry(list, date, title),
      do: list
          |> Map.update(date, [title], &([title | &1]))
  def entries(list, date),
      do: list
          |> Map.get(date, [])
end
