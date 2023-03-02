defmodule NaturalNumbers do
  def print(1) do
    IO.puts(1)
  end
  def print(n) do
    print(n-1)
    IO.puts(n)
  end


end
