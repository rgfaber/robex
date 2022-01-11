defmodule ServerProcess do

  def start(callback_module) do
    spawn(
      fn ->
        initial_state = callback_module.init()
        loop(callback_module, initial_state)
      end
    )
  end

  defp loop(callback_module, state) do
    receive do

      {:call, request, caller} ->
        {response, new_state} =
          callback_module.handle_call(request, state)
        send(caller, {:response, response})
        loop(callback_module, new_state)

      {:cast, request} ->
        new_state =
          callback_module.handle_cast(request, state)
        loop(callback_module, new_state)
      _ -> nil
    end
  end

  def call(server_id, request) do
    send(server_id, {:call, request, self()})
    receive do
      {:response, response} -> response
      _ -> nil
    end
  end

  def cast(server_id, request) do
    send(server_id, {:cast, request})
  end

end


defmodule KVStore do

  # Callback functions (defined in the generic process)
  def init() do
    %{}
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end


  # interface functions
  def start do
    ServerProcess.start(__MODULE__)
  end

  def put(pid, key, value) do
    ServerProcess.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end

end