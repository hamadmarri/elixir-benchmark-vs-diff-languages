defmodule Csp.NormalList.Children do
  # 8
  @entropy 7
  # 8
  @max_digit 7

  # initialize children
  def init() do
    # IO.puts("q INIT CHILDREN")

    # in the form .., [2], [1]
    @entropy..1 |> Stream.map(&[&1])
  end

  def generate(q, parent_items, stat)
      when length(parent_items) >= @max_digit do
    # IO.puts("MAX DIGIT for #{inspect(parent_items)}")
    {q, stat}
  end

  def generate(q, parent_items, stat) do
    # IO.puts("GEN CHILDREN for #{inspect(parent_items)}")

    children =
      Stream.map(1..@entropy, fn c ->
        [c | parent_items]
      end)

    # IO.puts("CHI")
    # IO.inspect(Enum.to_list(children))

    # create separate lists for each child
    q =
      Enum.reduce(children, q, fn c, q -> [c | q] end)
      |> Stream.each(&[&1])

    # IO.inspect(Enum.to_list(q))
    {q, stat + @entropy}
  end
end
