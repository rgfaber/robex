defmodule BigFile.Tests do
  use ExUnit.Case
  
  doctest BigFile
  
  test "Test that returns a list of numbers where number=length of line" do
    path = "./bible.txt"
    assert BigFile.LineLength.line_lengths!(path) 
           |> Enum.to_list() != []
  end
  
  
end