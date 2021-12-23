defmodule Streams do

  defmodule Simple do
    def with_enum(list) do
      list
      |> Enum.with_index()
      |> Enum.map(fn {name,index} -> "#{index+1}. #{name}" end)
    end

    def with_stream(list) do
      list
      |> Stream.with_index()
      |> Enum.map( fn {name,index} -> "#{index+1}. #{name}" end)
    end   
  end
  
  defmodule SquareRoot do
    def get_square_roots(list) do
      list
      |> Stream.filter( &( is_number(&1) and &1>0 ) )
      |> Stream.map(&( {&1, :math.sqrt(&1)} ))
      |> Enum.to_list()
    end
    
  end
  

  
end