defmodule ToDo do
  defstruct auto_id: 1, entries: %{}

  defimpl String.Chars, for: ToDo do
    def to_string(_), do: "#ToDo"
  end

  defimpl Collectable, for: ToDo do
    def into(original), do: {original, &into_callback/2}
    def into_callback(todos, {:cont, entry}), do: ToDo.add_entry(todos, entry)
    def into_callback(todos, :done), do: todos
    def into_callback(todos, :halt), do: :ok
  end

  def new(new_entries \\ []) do
    new_entries
    |> Enum.reduce(
         %ToDo{},
         &add_entry(&2, &1)
       )
    #         fn entry, acc_list -> add_entry(acc_list, entry) end)  
  end

  #  def new(), do: %ToDo{}

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

  def entries(list, title) do
    list.entries
    |> Stream.filter(fn {_, entry} -> entry.title == title end)
      #    |> Map.map(fn {_, entry} -> entry end)
      #      # We use Enum in order to let everything happen in 1 iteration over the filter result
    |> Enum.to_list()
    #    |> IO.inspect()    
  end

  def entries(list, date) do
    list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
      #    |> Map.map(fn {_, entry} -> entry end)
      #      # We use Enum in order to let everything happen in 1 iteration over the filter result
    |> Enum.to_list()
    #    |> IO.inspect()
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


  def update(list, %{} = new_entry) do
    update(list, new_entry.id, fn _ -> new_entry end)
  end

  def delete(list, del_entry) do
    list.entries
    |> Stream.filter(fn {_, entry} -> entry.id != del_entry.id end)
    |> Enum.to_list()
  end
end

defmodule ToDoServer do

  def start(path) do
    spawn(fn -> loop(ToDo.CsvImporter.read(path)) end)
  end

  defp loop(current_state) do
    new_state =
      receive do
        msg -> process_message(current_state, msg)
        #        _ -> log(current_state, "catch all")
        ##        _ -> current_state
      end
    loop(new_state)
  end

  defp process_message(state, {:query_by_date, requester_id, date})  do
    send(requester_id, {:entries, ToDo.entries(state, date)})
    state
  end

  defp process_message(state, {:query_by_title, requester_id, title})  do
    send(requester_id, {:entries, ToDo.entries(state, title)})
    state
  end


  defp process_message(state, {:add_todo, requester_id, entry}) do
    result = ToDo.add_entry(state, entry)
    send(requester_id, {:entries, result})
    result
  end


  defp process_message(state, {_, requester_id, msg}),
       do: send(requester_id, {:unknown, msg})

  defp process_message(state, other),
       do: log(state, other)

  defp log(state, msg) do
    IO.puts("logging: #{msg}")
    Process.info(self, :messages)
    |> IO.inspect()
    state
  end


end


defmodule ToDoServer.Client do

  def query(pid, receiver_id, date) do
    send(pid, {:query_by_date, receiver_id, date})
    receive do
      {:entries, entries} -> entries
      _ -> nil
    after
      5000 -> {:error, :timeout}
    end
  end

  def query(pid, receiver_id, title) do
    send(pid, {:query_by_title, receiver_id, title})
    receive do
      {:entries, entries} -> entries
      _ -> nil
    after
      5000 -> {:error, :timeout}
    end
  end


  def add_todo(pid, receiver_id, entry) do
    send(pid, {:add_todo, receiver_id, entry})
    receive do
      {:entries, entries} -> entries
      _ -> nil
    after
      5000 -> {:error, :timeout}
    end
  end

  def del_todo(pid, receiver_id, item_id) do
    send(pid, {:del_todo, receiver_id, item_id})
    receive do
      {:entries, entries} -> entries
      _ -> nil
    after
      5000 -> {:error, :timeout}
    end
  end



end


