defmodule ToDo.DbSupervisor do

  @doc """
  The Persistence Process for our ToDo WebServer
  """

  @db_path "./db"
  @db_pool_size 10000

  # Interface Methods
  def start_link() do
    IO.puts("Starting the ToDo.DbSupervisor")
    File.mkdir_p!(@db_path)
    children =  Enum.map(1..@db_pool_size, &worker_spec/1)
    Supervisor.start_link(children, strategy: :one_for_one)
  end
  
  def child_spec(_) do
    %{
       id: __MODULE__,
       start: {__MODULE__, :start_link, []},
       type: :supervisor
    }
  end

  
  defp worker_spec(key) do
    Supervisor.child_spec(
      {ToDo.DatabaseWorker, {@db_path, key}}, 
      id: key
    )
  end

  defp choose_worker(key) do
    :erlang.phash2(key, @db_pool_size) + 1
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

  def handle_call({:worker_spec, key}, _, state) do
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
