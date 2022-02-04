defmodule ToDo.Metrics do
  use Task
  
  def start_link(_arg) do
    IO.puts("Starting ToDo.Metrics")
    Task.start_link(&loop/0)
  end

  defp loop() do
    Process.sleep(:timer.seconds(10))
    IO.inspect(collect_metrics())
    loop()
  end

  defp collect_metrics() do
    [
      memory_usage: :erlang.memory(:total),
      process_count: :erlang.system_info(:process_count),
      process_limit: :erlang.system_info(:process_limit)
    ]
  end
  
  
end