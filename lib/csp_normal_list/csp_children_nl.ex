defmodule Csp.NormalList.Children do
  @entropy 10
  @max_digit 10

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

  def generate(q, _parent, parent_items, _children, stat)
      when parent_items == [] do
    # IO.puts("DONE WITH #{inspect(parent_items)}")
    {tl(q), stat}
  end

  def generate(q, parent, parent_items, children, stat) do
    # IO.puts("GEN CHILDREN for #{inspect(parent_items)}")

    {_, rest} = Range.split(children, 1)
    new_head = {parent, rest}
    q = [new_head | tl(q)]
    gen = {parent_items, @entropy..1//-1}
    q = [gen | q]

    # add children to stack
    {q, stat + @entropy}
  end
end
