defmodule ProcessPlayground do
  
  def sleeper(identifier) do
    Process.sleep(2000)
    "Sleeper #{identifier} is done."
    |> IO.inspect()
  end
  
    
  def spawn_sleeper(id) do
    spawn(fn -> ProcessPlayground.sleeper(id) end)
    |> IO.inspect()
  end
  
   
  
  
  
  
  
  
end