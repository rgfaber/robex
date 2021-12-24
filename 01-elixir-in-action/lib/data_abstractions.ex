defmodule DataAbstractions do

  defmodule DoW do

    def days_of_the_week() do
      MapSet.new()
      |> MapSet.put(:monday)
      |> MapSet.put(:tuesday)
      |> MapSet.put(:wednesday)
      |> MapSet.put(:thursday)
      |> MapSet.put(:friday)
      |> MapSet.put(:saturday)
      |> MapSet.put(:sunday)
    end
  end

end