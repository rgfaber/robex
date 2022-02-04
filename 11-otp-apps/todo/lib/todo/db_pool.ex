defmodule ToDo.DbPool do

  @doc """
  The Persistence Process for our ToDo WebServer
  """

  @db_path "./db"
  @db_pool_size 5


  
  def child_spec(_) do
    File.mkdir_p!(@db_path)
    :poolboy.child_spec(
      __MODULE__,
      [
        name: {:local, __MODULE__},
        worker_module: ToDo.PooledWorker,
        size: @db_pool_size
      ],
      [@db_path]
    )
  end

  defp worker_spec(key) do
    Supervisor.child_spec(
      {ToDo.PooledWorker, {@db_path, key}},
      id: key
    )
  end

  defp choose_worker(key) do
    :erlang.phash2(key, @db_pool_size) + 1
  end

  def get(key) do
    :poolboy.transaction(
    __MODULE__,
    fn worker_pid -> ToDo.PooledWorker.get(worker_pid, key) end
    )
  end

  def store(key, data) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid -> ToDo.PooledWorker.store(worker_pid, key, data)  end)
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
      {:ok, pid} = ToDo.PooledWorker.start_link({@db_path,index})
      {index - 1, pid}
    end
  end




end
