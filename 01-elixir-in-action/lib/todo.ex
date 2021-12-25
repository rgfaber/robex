defmodule ToDo do
  defstruct auto_id: 1, entries: %{}

  def new(), do: %ToDo{}

  def add_entry(list, entry) do
    # set the entry's id to the value stored in auto_id
    # We use this technique because there might not be an id present in the entry map
    # {entry | id: auto_id} would only work if the id field is already present in the entry map
    entry = Map.put(entry, :id, list.auto_id)
    # add the entry to the entries in the %ToDo{} struct 
    new_entries = Map.put(list.entries, list.auto_id, entry)
    # Update the struct with new entries and augment auto_id (for next use)
    %ToDo{list | entries: new_entries, auto_id: list.auto_id + 1}
  end

  def entries(list, date) do
    list.entries
    |> Stream.filter(fn {id, entry} -> entry.date == date end)
      # We use Enum in order to let everything happen in 1 iteration over the filter result
    |> Enum.map(fn {id, entry} -> entry end)
  end

  def update(list, id_to_update, updater_fun) do
    case Map.fetch(list.entries, id_to_update) do
      :error -> list
      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        # Here we impose that the result of updater_fun must return a map with an id == old_entry_id
        new_entry = %{id: ^old_entry_id} = updater_fun.(old_entry)
        new_entries = Map.put(list.entries, new_entry.id, new_entry)
        %ToDo{list | entries: new_entries}
    end
  end
  
  def update(list, %{}=new_entry) do
    update(list, new_entry.id, fn _ -> new_entry end)
  end



end
