defmodule ToDo.Server do
  use GenServer

  ## Callback Methods
  @impl GenServer
  def init(list_name) do
    send(self(), :init_state)
    {:ok, {list_name, nil}}
  end

  @impl GenServer
  def handle_info(:init_state, state) do
    {list_name, _} = state
    {:noreply, {list_name, ToDo.Database.get(list_name) || ToDo.List.new()}}
  end


  @impl GenServer
  def handle_cast({:add_entry, new_entry}, state) do
    {list_name, entries} = state
    new_entries =
      entries
      |> ToDo.List.add_entry(new_entry)
    ToDo.Database.store(list_name, new_entries)
    {:noreply, {list_name, new_entries}}
  end

  @impl GenServer
  def handle_call({:entries_by_date, date}, _caller, state)  do
    {name, _} = state
    {_, entries} =
      answer = ToDo.Database.get(name)
               |> ToDo.List.entries_by_date(date)
    {:reply, answer, state}
  end

  @impl GenServer
  def handle_call({:entries_by_title, title}, _caller, state)  do
    {name, _} = state

    answer = ToDo.Database.get(name)
             |> ToDo.List.entries_by_title(title)
    {:reply, answer, state}
  end


  @impl GenServer
  def handle_call({:entries_all}, _caller, state) do
    {name, list} = state
    answer = ToDo.Database.get(name)
             |> ToDo.List.entries()
    {:reply, answer, state}
  end




  ## Interface functions
  def start(list_name) do
    GenServer.start(__MODULE__, list_name)
  end


  def get_by_title(server, title) do
    GenServer.call(server, {:entries_by_title, title})
  end

  def get_by_date(server, date)  do
    GenServer.call(server, {:entries_by_date, date})
  end

  def get_all(server)  do
    GenServer.call(server, {:entries_all})
  end

  def put(server, key, value) do
    GenServer.cast(server, {:add_entry, %{date: key, title: value}})
    |> IO.inspect()
  end



end