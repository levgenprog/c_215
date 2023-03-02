defmodule Mapsum do
  def mapsum([], _) do
    0
  end
  def mapsum([head | tail], func) do
    func_res = func.(head)
    sum_tail = mapsum(tail, func)
    _ = func_res + sum_tail
  end
end
