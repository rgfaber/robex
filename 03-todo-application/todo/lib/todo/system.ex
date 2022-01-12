defmodule ToDo.System do
  use Supervisor
  
  # Interface
  def start_link() do
    IO.puts("Starting ToDo.System")
    Supervisor.start_link(__MODULE__, nil)
  end
  
  # Callback
  def init(_) do
    Supervisor.init([ToDo.Cache], strategy: :one_for_one)
  end
  
end