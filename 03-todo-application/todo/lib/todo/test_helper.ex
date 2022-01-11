defmodule ToDo.TestHelper do
  # Can we create a Helper Function to start the usual suspects? Yes we can!
  def start_beatles() do
    {_,cache_id} = ToDo.Cache.start()
    ToDo.Cache.get_process(cache_id, :john)
    ToDo.Cache.get_process(cache_id, :george)
    ToDo.Cache.get_process(cache_id, :ringo)
    ToDo.Cache.get_process(cache_id, :paul)
    ToDo.Cache.get_process(cache_id, :pete)
    IO.puts("\n\n The Beatles have started!")
    {:beatles, cache_id}
  end

end
  
  