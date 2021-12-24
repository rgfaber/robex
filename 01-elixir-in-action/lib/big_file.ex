defmodule BigFile do
  @moduledoc """
  documentation for 'BigFile'
  """
  defmodule LineLength do

    def line_lengths!(path) do
      File.stream!(path)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Stream.filter(&(String.length(&1) > 0))
      |> Stream.with_index()
      |> Stream.map(fn {line, index} -> {index, String.length(line), line}  end)
    end

    def longest_line!(path) do
      line_lengths!(path)
      |> Enum.sort_by(fn {index, length, text} -> length end, &>=/2)
      |> Enum.take(1)
    end



  end



end