defmodule ToDo.Cache do
  use GenServer


  ## Interfaces Methods
  def start_link(_) do
    IO.puts("Starting the ToDo.Cache")
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_process(todo_list_name) do
    GenServer.call(__MODULE__, {:server_process, todo_list_name})
  end

  def fetch_all_servers() do
    GenServer.call(__MODULE__, {:all_servers})
  end

  def child_spec(args) do
    %{id: ToDo.Cache, start: {ToDo.Cache, :start_link, [args]}}
  end




  ## Callback Methods
  @impl GenServer
  def init(_) do
    ToDo.Database.start_link()
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