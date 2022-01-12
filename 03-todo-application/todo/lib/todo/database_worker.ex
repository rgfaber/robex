defmodule ToDo.DatabaseWorker do
  use GenServer

  @doc """
  The Persistence Process for our ToDo WebServer
  """

  # Interface Methods
  def start_link(folder) do
    IO.puts("Starting the ToDo.DatabaseWorker")
    GenServer.start_link(__MODULE__, folder)
  end

  def store(worker, key, data) do
    GenServer.cast(worker, {:store, key, data})
  end

  def get(worker, key) do
    GenServer.call(worker, {:get, key})
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
          _ -> nil
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
