defmodule From_to do
  def from_to(from, to) when from <= to do
      to_list(from, to, [])
  end
  def from_to(from, to) do
    to_list(to, from, [])
  end

  def to_list(to, to, lst) do
    [to | lst]
  end
  def to_list(from, to, lst) do
    to_list(from, to-1, [to | lst])
  end
end

From_to.from_to(4, 10);
