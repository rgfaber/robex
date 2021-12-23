defmodule Looping do

  #  sum_of
  defmodule Sum do

    def sum_of([]), do: 0
    def sum_of([head | tail]), do: head + sum_of(tail)

    def tail_recursive_sum_of(list), do: internal_sum_of(0, list)

    ## the advantage of using tail-recursion is that it does not consume additional memory
    ## see page 89 of "Elixir in Action"    

    defp internal_sum_of(current, []), do: current # <- defp = 'private' function 
    defp internal_sum_of(current, [head | tail]), do: internal_sum_of(current + head, tail)

  end

  defmodule ListLen do
    def length_of_list([]), do: 0
    def length_of_list([head | tail]) do
      list_length(0, [head | tail])
    end
    defp list_length(len, []), do: len
    defp list_length(len, [_ | tail]), do: list_length(len + 1, tail)
  end

  defmodule Ranger do
    def get_range(a, b) when a == b, do: a
    def get_range(a, b) when (a - b) == 1 or (b - a) == 1,
        do: :undefined
    def get_range(a, b) when a < 0 or b < 0,
        do: :negatives_not_supported
    def get_range(a, b) when b < a,
        do: :reverse_order_not_supported
    def get_range(a, b) do
      range(a, b, [])
    end
    defp range(a, b, result) when a > b,
         do: result
    defp range(a, b, result),
         do: range(a, b - 1, [b | result])
  end

  defmodule Positives do
    def get_positives([]), do: []
    def get_positives(list) do
      positives_filter(list, [])
    end
    
    defp positives_filter([], result), do:  Enum.reverse(result)
    defp positives_filter([head | tail], result) when head >= 0, # when head is positive
         do: positives_filter(tail, [head | result]) # add the head to the result
    defp positives_filter([_ | tail], result), # default fallthrough (when head is <=0)
         do: positives_filter(tail, result)
  end


  defmodule Naturals do
    def print(1), do: IO.puts(1)
    def print(n) when n >= 1 do
      print(n - 1)
      IO.puts(n)
    end
    def print(n) when n <= 0 do
      IO.puts("no zeroes or negatives!")
    end
  end

end