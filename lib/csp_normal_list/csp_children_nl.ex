defmodule Csp.NormalList.Children do
  @entropy 10
  @max_digit 10

  # initialize children
  def init() do
    # IO.puts("q INIT CHILDREN")

    # in the form [1], [2], ..
    Enum.to_list(1..@entropy) |> Enum.map(&[&1]) |> Enum.reverse()
  end

  def generate(q, parent_items, stat)
      when length(parent_items) >= @max_digit do
    # IO.puts("MAX DIGIT for #{inspect(parent_items)}")
    {q, stat}
  end

  def generate(q, parent_items, stat) do
    # IO.puts("GEN CHILDREN for #{inspect(parent_items)}")
    children = for c <- @entropy..1, do: [c | parent_items]

    # add children to stack
    {children ++ q, stat + @entropy}
  end
end
