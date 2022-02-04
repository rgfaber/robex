defmodule ToDo.Server do
  use GenServer, restart: :temporary

  def start_link(name) do
    GenServer.start_link(ToDo.Server, name, name: via_tuple(name))
  end

  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  def by_date(todo_server, date) do
    GenServer.call(todo_server, {:entries_by_date, date})
  end

  def all(todo_server) do
    GenServer.call(todo_server, {:all_entries})
  end

  defp via_tuple(name) do
    ToDo.ProcessRegistry.via_tuple({__MODULE__, name})
  end

  @expiry_idle_timeout :timer.seconds(10)

  @impl GenServer
  def init(name) do
    IO.puts("Starting ToDo.Server for #{name}")
    {:ok, {name, ToDo.DbPool.get(name) || ToDo.List.new()}, @expiry_idle_timeout}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, {name, todo_list}) do
    new_list = ToDo.List.add_entry(todo_list, new_entry)
    ToDo.DbPool.store(name, new_list)
    {:noreply, {name, new_list}, @expiry_idle_timeout}
  end

  @impl GenServer
  def handle_call({:entries_by_date, date}, _, {name, todo_list}) do
    {
      :reply,
      ToDo.List.entries_by_date(todo_list, date),
      {name, todo_list},
      @expiry_idle_timeout
    }
  end


  @impl GenServer
  def handle_call({:all_entries}, _, {name, todo_list}) do
    {
      :reply,
      ToDo.List.all_entries(todo_list),
      {name, todo_list},
      @expiry_idle_timeout
    }
  end

  @impl GenServer
  def handle_info(:timeout, {name, todo_list}) do
    IO.puts("Stopping to-do server for #{name}")
    {:stop, :normal, {name, todo_list}}
  end
end
