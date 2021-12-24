defmodule ToDo do
  def new(), do: MultiDict.new()
  def add_entry(list, entry),
      do: MultiDict.add(list,entry.date, entry)
  def entries(list, date),
      do: MultiDict.get(list,date)
end
