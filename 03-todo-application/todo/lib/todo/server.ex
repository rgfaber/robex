defmodule ToDo.Server do
  use GenServer, restart: :temporary


  @expiry_idle_timeout :timer.seconds(10)
  ## Interface functions

  defp via_tuple(list_name) do
    ToDo.ProcessRegistry.via_tuple({__MODULE__, list_name})
  end


  def start_link(list_name) do
    IO.puts("Starting ToDo.Server for #{list_name}")
    GenServer.start_link(__MODULE__, list_name, name: via_tuple(list_name))
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
  end




  ## Callback Methods
  @impl GenServer
  def init(name) do
    {
      :ok,
      {name, ToDo.DbSupervisor.get(name) || Todo.List.new()},
      @expiry_idle_timeout
    }
  end


  @impl GenServer
  def handle_info(:init_state, state) do
    {list_name, _} = state
    {
      :noreply, 
      {list_name, ToDo.DbSupervisor.get(list_name) || ToDo.List.new()}, 
      @expiry_idle_timeout
    }
  end
  
  
  @impl GenServer
  def handle_info(:timeout, {name, todo_list}) do
    IO.puts("Stopping ToDo.Server for #{name}")
    {:stop, :normal, {name, todo_list}}
  end


  @impl GenServer
  def handle_cast({:add_entry, new_entry}, state) do
    {list_name, entries} = state
    new_entries =
      entries
      |> ToDo.List.add_entry(new_entry)
    ToDo.DbSupervisor.store(list_name, new_entries)
    {
      :noreply, 
      {list_name, new_entries}, 
      @expiry_idle_timeout
    }
  end

  @impl GenServer
  def handle_call({:entries_by_date, date}, _caller, state)  do
    {name, _} = state
    {_, entries} =
      answer = ToDo.DbSupervisor.get(name)
               |> ToDo.List.entries_by_date(date)
    {
      :reply, 
      answer, 
      state, 
      @expiry_idle_timeout
    }
  end

  @impl GenServer
  def handle_call({:entries_by_title, title}, _caller, state)  do
    {name, _} = state
    answer = ToDo.DbSupervisor.get(name)
             |> ToDo.List.entries_by_title(title)
    {
      :reply, 
      answer, 
      state,
      @expiry_idle_timeout
    }
  end


  @impl GenServer
  def handle_call({:entries_all}, _caller, state) do
    {name, list} = state
    answer = ToDo.DbSupervisor.get(name)
             |> ToDo.List.entries()
    {
      :reply, 
      answer, 
      state,
      @expiry_idle_timeout
    }
  end






end