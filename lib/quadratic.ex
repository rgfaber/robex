defmodule Quadratic do

  def discriminator(a,b,c) do
    d = b*b-4*a*c
    if ( d>=0 ) do
      {:real,d}  
    else 
      {:imaginary}
    end 
  end
  
end