defmodule Robex do
  @moduledoc """
  Documentation for `Robex`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Robex.hello()
      :world

  """
  def hello, do: :world

  def run(N) do
    case start_robot(N) do
      {:all_started, msg} -> IO.puts(msg)
    end
  end

  def start_robot(N) do
    if N == 0 do
      "All robots Started."
    end
    pid = spawn(fn -> Robex.Robot.move(N, 1, 1) end)
    start_robot(N - 1)
  end

end

