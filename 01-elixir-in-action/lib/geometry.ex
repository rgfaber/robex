defmodule Robex.Geometry do

  def area({:circle, r}) do
    {:circle, r * r * 3.14}
  end

  def area({:square, w}) do
    {:square, w * w}
  end

  def area({:rectangle, w, h}) do
    {:rectangle, w * h}
  end

  def area(_) do
    {:error, {:unknown_shape, :unknown}}
  end

end