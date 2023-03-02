defmodule Tax do
  def find_tax(amount) when(amount < 2000) do
    tax = amount * 0
    IO.puts("Tax = #{tax}")
    IO.puts("Wage = #{amount - tax}")
  end
  def find_tax(amount) when(amount >= 2000 and amount <= 3000) do
    tax = amount * 0.05
    IO.puts("Tax = #{tax}")
    IO.puts("Wage = #{amount - tax}")
  end
  def find_tax(amount) when(amount > 3000 and amount <= 6000) do
    tax = amount * 0.1
    IO.puts("Tax = #{tax}")
    IO.puts("Wage = #{amount - tax}")
  end
  def find_tax(amount) when(amount > 6000) do
    tax = amount * 0.15
    IO.puts("Tax = #{tax}")
    IO.puts("Wage = #{amount - tax}")
  end
end

user_input = IO.gets("Enter your salary ")

case Integer.parse(user_input) do
  :error ->
    IO.puts("Invalid")
  {user_input_int, _} -> Tax.find_tax(user_input_int)
end
