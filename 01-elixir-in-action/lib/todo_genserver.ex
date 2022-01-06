defmodule ToDoGenServer do
  use GenServer
  
  ## Callback Methods
  @impl GenServer
  def init(_) do
    {:ok, ToDo.new() }
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, state) do
    new_state =
    state
    |> ToDo.add_entry(new_entry)
    {:no_reply, new_state}
  end
  
  @impl GenServer
  def handle_call({:entries, date}, state)  do
    answer = state 
             |> ToDo.entries(date)
    {:reply, answer,  state}
  end
  
  @impl GenServer
  def handle_call({:entries}, state) do
    answer = state
    {:reply, answer, state}
  end
  
  
  

  ## Interface functions
  def start() do
    GenServer.start(__MODULE__, nil)
  end
  
  
  
  def get(server, key)  do  
    GenServer.call(server, {:entries, key})
  end

  def get_all(server)  do
    GenServer.call(server, {:entries})
  end


  def put(server, key, value) do
    GenServer.cast(server, {:add_entry, %{date: key, title: value}})
    |> IO.inspect()
  end
  
  
  
end