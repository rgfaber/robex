defmodule ToDo.DatabaseWorker do
  use GenServer

  @doc """
  The Persistence Process for our ToDo WebServer
  """

  # Interface Methods
  def start_link({folder, worker_id}) do
    IO.puts("Starting the ToDo.DatabaseWorker #{worker_id}")
    GenServer.start_link(__MODULE__, 
      folder, 
      name: via_tuple(worker_id))
  end
  
  defp via_tuple(worker_id) do
    ToDo.ProcessRegistry.via_tuple({__MODULE__, worker_id})
  end

  def store(worker_id, key, data) do
    GenServer.cast(via_tuple(worker_id), {:store, key, data})
  end

  def get(worker_id, key) do
    GenServer.call(via_tuple(worker_id), {:get, key})
  end


  # Callback Methods

  def init(folder) do
    case File.mkdir_p!(folder) do
      {:error, reason} -> IO.puts("Error creating directory! Reason: #{reason}}")
                          {:error, reason}
      _ -> {:ok, folder}
    end
  end

  def handle_call({:get, key}, caller, folder) do
    spawn(
      fn ->
        data = case file_name(folder, key)
                    |> File.read() do
          {:ok, contents} -> :erlang.binary_to_term(contents)
          {:error, :enoent} -> nil
        end
        GenServer.reply(caller, data)
      end
    )
    {:noreply, folder}
  end

  def handle_cast({:store, key, data}, folder) do
    spawn(
      fn ->
        file_name(folder, key)
        |> File.write!(:erlang.term_to_binary(data))
      end
    )
    {:noreply, folder}
  end

  ## Helper functions
  defp file_name(folder, key) do
    Path.join(folder, to_string(key))
  end



end
