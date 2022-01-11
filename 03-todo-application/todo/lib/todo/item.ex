defmodule ToDo.Item do
  defstruct id: 1,
            date: ~D[1970-01-01],
            title: "New ToDo Item"

  defimpl String.Chars, for: ToDo.Item do
    def to_string(item) do
      "\nToDo.Item: \tid: #{item.id} \tdate: #{item.date} \ttitle: #{item.title}"
    end
  end


  def new(id, date, title) do
    %ToDo.Item{id: id, date: date, title: title}
  end

end


