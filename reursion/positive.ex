defmodule Positive do
  def get_positive([]) do
    []
  end
  def get_positive([head | []]) when head > 0 do
    [head]
  end
  def get_positive([head | tail]) when head > 0 do
    [head | get_positive(tail)]
  end
  def get_positive([head | tail]) when head < 0 do
    get_positive(tail)
  end
end
