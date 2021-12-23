defmodule Looping do

#  sum_of
  defmodule Sum do
 
    def sum_of([]), do: 0
    def sum_of([head|tail]), do: head + sum_of(tail)
    
    def tail_recursive_sum_of(list), do: internal_sum_of(0,list)
    
    defp internal_sum_of(current,[]), do: current
    defp internal_sum_of(current, [head|tail]) do
      new_sum = current + head
      internal_sum_of(new_sum, tail)
    end
  end
  
  
  
  
  defmodule Naturals do
    def print(1), do: IO.puts(1)
    def print(n) when n>=1 do
      print(n-1)
      IO.puts(n)
    end
    def print(n) when n<=0 do
      IO.puts("no zeroes or negatives!")
    end
  end
    
end