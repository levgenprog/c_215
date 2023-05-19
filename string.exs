defmodule St do
  def str_frst(str) do
    IO.puts(String.at(str, 0))
  end

  def get_last(str) do
    IO.puts(String.at(str, -1))
  end

  def rem_first(s) do
    IO.puts(String.slice(s, 1, String.length(s) - 1))
  end

  def rem_last(s) do
    IO.puts(String.slice(s, 0, String.length(s)-1))
  end

  def list_esp(expr, num) do
    IO.puts(List.duplicate(expr, num))
  end

  def list_count(lst) do
    Enum.reduce(lst, 0, fn
      x when is_number(x) -> acc + 1
      x when is_list(x) -> acc + list_count(x)
      _, acc -> acc
    end)
  end
end

St.list_esp("hello", 2)
