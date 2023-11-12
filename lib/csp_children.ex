defmodule Csp.Children do
  @entropy 10
  @max_digit 8

  # initialize children
  def init() do
    IO.puts("q INIT CHILDREN")

    # in the form [1], [2], ..
    children = Enum.to_list(1..@entropy) |> Enum.map(&[&1])
    :queue.from_list(children)
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

    case Enum.empty?(children) do
      true ->
        {q, stat}

      false ->
        # create separate lists for each child
        new_items = for c <- children, do: [c | parent_items]

        # add new items to the queue
        q = new_items |> Enum.reduce(q, fn n, q -> :queue.in(n, q) end)
        {q, stat}
    end
  end
end
