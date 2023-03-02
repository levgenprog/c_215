defmodule Compare do
  def greater(number, other) do
    check(number >= other, number, other)
  end
  defp check(True, number, _) do
    number
  end
  defp check(false, _, other) do
    other
  end
end
