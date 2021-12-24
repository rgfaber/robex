defmodule DataAbstractions.Tests do
  use ExUnit.Case
  doctest DataAbstractions

  test "Test that we can create a MapSet that includes the days of the week" do

    assert  DataAbstractions.DoW.days_of_the_week()
            |> MapSet.member?(:tuesday) == :true

  end
end