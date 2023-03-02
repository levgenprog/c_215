defmodule FizzBuss do
  def check(_, 0, _) do
    "Buzz"
  end
  def check(0, 0, _) do
    "FizzBuzz"
  end
  def check(0, _, _) do
    "Fizz"
  end
  def check(_, _, n) do
    n
  end
  def interview(n) do
   check(rem(n, 3), rem(n, 5), n)
  end
end
