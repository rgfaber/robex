defmodule ProcessPlayground do
  
  def sleeper(identifier) do
    Process.sleep(2000)
    "Sleeper #{identifier} is done."
  end
  
    
  def spawn_sleeper(id) do
    caller = self()
    spawn(fn -> send(caller, {:query_result, ProcessPlayground.sleeper(id)}) end)
    spawn(fn -> receive_message() end)
    |> IO.inspect()
  end
  
  def receive_message() do
    receive do
      {:query_result, message} -> IO.inspect(message)
    after
      5000 -> "No messages" 
    end
  end
  
  
   
  
  
  
  
  
  
end