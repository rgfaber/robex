defmodule ToDo.Database do
  use GenServer

  @doc """
  The Persistence Process for our ToDo WebServer
  """

  @db_path "./db"
  @db_pool_size 3
  
  # Interface Methods
  def start_link(_) do
    IO.puts("Starting the ToDo.Database")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def choose_worker(key) do
    GenServer.call(__MODULE__, {:choose_worker, key})
  end

  def get(key) do
    choose_worker(key)
    |> ToDo.DatabaseWorker.get(key)
  end

  def store(key, data) do
    choose_worker(key)
    |> ToDo.DatabaseWorker.store(key, data)
  end


  # Callback Methods

  def init(_) do
    {:ok, create_pool()}
  end

  def handle_call({:choose_worker, key}, _, state) do
    worker =
      state
      |> Map.get(:erlang.phash2(key, 3))
    {:reply, worker, state}
  end

  def create_pool() do
    for index <- 1..3, into: %{} do
      {:ok, pid} = ToDo.DatabaseWorker.start_link({@db_path,index})
      {index - 1, pid}
    end
  end




end
