defmodule DbServer do
    
  @moduledoc """
   This module contains a low-level implementation for  a DbServer
  """
  
  @doc """
  Starts the server and calls the tail-iterative loop
  """
  def start() do
    spawn(&loop/0)
  end
  
  defmodule Client do
    @doc """
    Client method to run a query against the DbServer
    """
    def query_async(server_pid, query_def) do
      send(server_pid, {:run_query, self(), query_def})
    end
    
    @doc """
    Client method to retrieve the result from the query_async call
    times out after 5 seconds
    """
    def get_result() do
      receive do
        {:query_result, result} -> result
      after
        5000 -> {:error, :timeout}
      end
    end
  end
  
  defp loop() do
    receive do
      {:run_query, caller_pid, query_def} -> 
        send(caller_pid, {:query_result, run_query(query_def)}) 
    end
    IO.puts(self)
    loop()
  end
  
  defp run_query(query_def) do
    Process.sleep(2000)
    "#{query_def} result"
  end
  
end