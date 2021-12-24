defmodule Fraction do
  defstruct a: nil, b: nil

  def new(a, b), do: %Fraction{a: a, b: b}

  def value(%Fraction{a: a, b: b}), do: a / b

end