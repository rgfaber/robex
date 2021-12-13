defmodule RobexTest do
  use ExUnit.Case
  doctest Robex

  test "greets the world" do
    assert Robex.hello() == :world
  end
end
