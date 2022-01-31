defmodule KeyValue do
  use GenServer

  ## Interface functions
  def start(state) do
    GenServer.start(__MODULE__, state)
  end

  def start(state, name) do
    GenServer.start(__MODULE__, state, name: name)
  end


  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  ## Callback functions
  @impl GenServer
  def init(_) do
    :timer.send_interval(5000, :cleanup)
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl GenServer
  def handle_info(:cleanup, state) do
    IO.puts("Cleaning up KeyValue...")
    {:noreply, state}
  end


end