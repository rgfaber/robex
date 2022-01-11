defmodule ToDo.Cache do
  use GenServer


  ## Interfaces Methods
  def start() do
    GenServer.start(__MODULE__, nil)
  end

  def get_process(cache_id, todo_list_name) do
    GenServer.call(cache_id, {:server_process, todo_list_name})
  end

  def fetch_all_servers(cache_id) do
    GenServer.call(cache_id, {:all_servers})
  end




  ## Callback Methods
  @impl GenServer
  def init(_) do
    ToDo.Database.start()
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {
          :reply,
          todo_server,
          todo_servers
        }

      :error -> {:ok, new_server} = ToDo.Server.start(todo_list_name)
                {
                  :reply,
                  new_server,
                  todo_servers
                  |> Map.put(todo_list_name, new_server)
                }
    end
  end

  @impl GenServer
  def handle_call({:all_servers}, _, todo_servers) do
    {:reply, todo_servers, todo_servers}
  end





end