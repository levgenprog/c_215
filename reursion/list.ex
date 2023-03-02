defmodule MyList do
  def range(from, to) when from <= to, do: range_helper(from, to, [])
  def range(from, to), do: range_helper(to, from, [])

  defp range_helper(to, to, acc), do: [to | acc]
  defp range_helper(from, to, acc), do: range_helper(from, to-1, [to | acc])
end
