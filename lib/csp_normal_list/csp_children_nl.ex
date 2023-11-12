defmodule Csp.NormalList.Children do
  @entropy 8
  @max_digit 8

  # initialize children
  def init() do
    IO.puts("q INIT CHILDREN")

    # in the form [1], [2], ..
    Enum.to_list(1..@entropy) |> Enum.map(&[&1])
  end

  def generate(q, parent_items, stat)
      when length(parent_items) >= @max_digit do
    # IO.puts("MAX DIGIT for #{inspect(parent_items)}")
    {q, stat}
  end

  def generate(q, parent_items, stat) do
    # IO.puts("GEN CHILDREN for #{inspect(parent_items)}")
    children = Enum.to_list(1..@entropy)
    stat = stat + length(children)

    # create separate lists for each child
    q = Enum.reduce(children, q, fn c, q -> [[c | parent_items] | q] end)

    {q, stat}
  end
end
