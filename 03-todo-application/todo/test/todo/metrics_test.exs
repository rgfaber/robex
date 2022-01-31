defmodule ToDo.Metrics.Tests do
  use ExUnit.Case, async: true
  
  doctest ToDo.Metrics

  @tag :ignore
  test "if we can collect metrics" do
    collect_metrics()
    |> IO.inspect()
  end

  test "if we can start the ToDo.Metrics using start_link" do
    
  end
  
  defp collect_metrics() do
    [
      memory_usage: :erlang.memory(:total),
      process_count: :erlang.system_info(:process_count)
    ]
  end
  
  
  
  
end