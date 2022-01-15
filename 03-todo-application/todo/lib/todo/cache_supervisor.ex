defmodule ToDo.CacheSupervisor do
  use GenServer


  ## Interfaces Methods
  def start_link() do
    IO.puts("Starting the ToDo.Cache")
    DynamicSupervisor.start_link(
      name: __MODULE__, 
      strategy: :one_for_one
    )
  end
  
  def server_process(todo_list_name) do
    case start_child(todo_list_name) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end

  defp start_child(todo_list_name) do
    DynamicSupervisor.start_child(
      __MODULE__,
      {ToDo.Server, todo_list_name})
  end


  def child_spec(_args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end

  
  

  def fetch_all_servers() do
    GenServer.call(__MODULE__, {:all_servers})
  end

    



  ## Callback Methods
  


  @impl GenServer
  def init(_) do
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

      :error -> {:ok, new_server} = ToDo.Server.start_link(todo_list_name)
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