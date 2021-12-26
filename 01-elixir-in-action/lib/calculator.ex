defmodule Calculator do

  @moduledoc """
  This is the module for the Calculator stateful service
  """
  @doc """
  Let's start the Calculator
  """
  def start(initial_state) do
    spawn(fn -> loop(initial_state)  end)
  end

  defp loop(state) do
    new_state =
      receive do
        {:value, requester_id} -> send(requester_id, {:value, state})
                                  state
        {:add, value} -> state + value

        invalid_request -> IO.puts("#{inspect invalid_request}")
                           state
      end
    loop(new_state)
  end


  defmodule Client do

    def get_value(pid) do
      send(pid, {:value, self()})
      receive do
        {:value, state} -> state
      end
    end

    def add(pid, value), do: send(pid, {:add, value})

  end



end