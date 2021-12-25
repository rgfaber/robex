defmodule ToDo.CsvImporter do
  @moduledoc """
  This module implements a CsvImporter for files containing todo list entries 
  """

  
  
  def read(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.filter(&(String.length(&1) > 0))
    |> Stream.map(&parse_line(&1))
    |> Enum.map(&to_entry(&1))
#    # lets try someting.....-> BAD IDEA, neste captures are not allowed
#    |> Stream.map(&parse_line(&1) |> &to_entry(&1)) <- DOES NOT WORK
    |> ToDo.new()    
    |> IO.inspect()
  end
  
  defp to_entry(raw_entry) do
    {{y,m,d}, title} = raw_entry
    {:ok, date} = Date.new(y,m,d) 
    %{date: date, title: title}  # We need a map
  end
  
  defp parse_line(line) do
    [date, title] = String.split(line, ",")
    [y,m,d] = String.split(date, "/")
    {{String.to_integer(y), String.to_integer(m), String.to_integer(d)}, title}
  end
  
  
  
end
