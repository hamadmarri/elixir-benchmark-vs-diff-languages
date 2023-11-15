defmodule Csp.NormalList.Children do
  @entropy 8
  @max_digit 8

  # initialize children
  def init() do
    # IO.puts("q INIT CHILDREN")
    [{[], @entropy..1//-1}]
  end

  def generate(q, parent, parent_items, children, stat)
      when length(parent_items) >= @max_digit do
    # IO.puts("MAX DIGIT for #{inspect(parent_items)}")
    {_, rest} = Range.split(children, 1)
    new_head = {parent, rest}
    q = [new_head | tl(q)]
    {q, stat}
  end

  def generate(q, parent, parent_items, children, stat) do
    # IO.puts("GEN CHILDREN for #{inspect(parent_items)}")

    {_, rest} = Range.split(children, 1)

    case rest do
      0..1//-1 ->
        # IO.puts("generate: 0..1//-1")
        {tl(q), stat}

      _ ->
        new_head = {parent, rest}
        q = [new_head | tl(q)]
        gen = {parent_items, @entropy..1//-1}
        q = [gen | q]

        # add children to stack
        {q, stat + @entropy}
    end
  end
end
