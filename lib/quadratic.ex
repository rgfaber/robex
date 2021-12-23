defmodule Quadratic do
 

  def d(a, b, c) do
    d = b * b - 4 * a * c
    if (d >= 0) do
      {:real, d}
    else
      {:imaginary, d}
    end
  end

  def  roots(a, b, c)  do
    disc = d(a, b, c) 
    case disc  do
      {:real, disc} -> {:real, {(-b + :math.sqrt(disc)) / 2 * a * c, (-b - :math.sqrt(disc)) / 2 * a * c}}
#      {:imaginary, disc} -> {}
    end
  end


end