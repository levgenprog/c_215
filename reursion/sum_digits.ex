defmodule SumDigits do
  def sum_d(n) when n < 10 do
    n
  end
  def sum_d(n) do
    rem(n, 10) + sum_d(div(n, 10))
  end
end
