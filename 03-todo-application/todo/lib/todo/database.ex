defmodule ToDo.Database do
  use GenServer

  @doc """
  The Persistence Process for our ToDo WebServer
  """

  @db_path "./db"

  # Interface Methods
  def start() do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end


  # Callback Methods

  def init(_) do
    case File.mkdir_p!(@db_path) do
      {:error, reason} -> IO.puts("Error creating directory! Reasoon: #{reason}}")
                          {:error, reason}
      _ -> {:ok, nil}
    end
  end

  def handle_call({:get, key}, caller, state) do
    spawn(
      fn ->
        data = case file_name(key)
                    |> File.read() do
          {:ok, contents} -> :erlang.binary_to_term(contents)
          _ -> nil
        end
        GenServer.reply(caller, data)
      end
    )
    {:noreply, state}
  end

  def handle_cast({:store, key, data}, state) do
    spawn(
      fn ->
        key
        |> file_name
        |> File.write!(:erlang.term_to_binary(data))
      end
    )
    {:noreply, state}
  end


  ## Helper functions
  defp file_name(key) do
    Path.join(@db_path, to_string(key))
  end



end
