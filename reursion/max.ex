defmodule Max do
  def max([]) do
    []
  end
  def max([head | []]) do
    head
  end
  def max([head, head2 | tail]) when head > head2 do
    max([head | tail])
  end
  def max([head, head2 | tail]) when head <= head2 do
    max([head2 | tail])
  end
end
