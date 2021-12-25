defmodule ToDoEntry do
  @moduledoc false
  defstruct id: 0, date: ~D[1970-01-01], title: ""

  def new(),
      do: %ToDoEntry{}

  def new(entry_date, entry_title),
      do: %ToDoEntry{date: entry_date, title: entry_title}

end
