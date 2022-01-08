defmodule ToDo.Server do
  use GenServer
  
  ## Callback Methods
  @impl GenServer
  def init(_) do
    {:ok, ToDo.List.new() }
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, state) do
    new_state =
    state
    |> ToDo.List.add_entry(new_entry)
    {:noreply, new_state}
  end
  
  @impl GenServer
  def handle_call({:entries_by_date, date}, _caller, state)  do
    answer = state 
             |> ToDo.List.entries_by_date(date)
    {:reply, answer,  state}
  end

  @impl GenServer
  def handle_call({:entries_by_title, title}, _caller, state)  do
    answer = state
             |> ToDo.List.entries_by_title(title)
    {:reply, answer,  state}
  end


  @impl GenServer
  def handle_call({:entries_all}, _caller, state) do
    answer = state
             |> ToDo.List.entries()
    {:reply, answer, state}
  end
  
  
  

  ## Interface functions
  def start() do
    GenServer.start(__MODULE__, nil)
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