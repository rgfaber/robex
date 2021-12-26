defmodule Calculator.Tests do
  use ExUnit.Case


  @moduledoc """
  This module contains the tests for the Calculator stateful service
  """

  doctest Calculator

  @doc """
  Let's test if we can get the value in the calculator
  """
  test "Test if we can get the value in the calculator" do
    pid = Calculator.start(0)
          |> IO.inspect()
    value = Calculator.Client.get_value(pid)
            |> IO.inspect()
    assert value == 0
  end

  @doc """
  Lets test if the calculator can do the addition
  """
  test "Test if we can add an integer to the Calculator" do
    pid = Calculator.start(6)
          |> IO.inspect()
    Calculator.Client.add(pid, 10)
    |> IO.inspect()
    res = Calculator.Client.get_value(pid)
          |> IO.inspect()
    assert  res == 16
  end

  @doc """
  Let's see what happens if we send an invalid request
  """
  test "Test if Calculator can handle invalid requests" do
    pid = Calculator.start(0)
          |> IO.inspect()
    send(pid, "nonsense")
    res = Calculator.Client.get_value(pid)
          |> IO.inspect()
  end



end