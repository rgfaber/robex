defmodule ToDo.DatabaseWorker.Tests do
    use ExUnit.Case
    
    doctest ToDo.DatabaseWorker

    @db_folder "./db"
    @tag :ignore
    test "if we can start a ToDo.DatabaseWorker using start/1" do
        ToDo.DatabaseWorker.start(@db_folder)
        |> IO.inspect()
    end
    
    
    
  
        
    
    
end