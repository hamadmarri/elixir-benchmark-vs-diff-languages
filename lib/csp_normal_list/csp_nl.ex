defmodule Csp.NormalList do
  alias Csp.NormalList.Children
  alias Csp.NormalList.Solver

  # Steps:
  # q = [{[], 3..1//-1}]
  # h = hd(q)
  # {p, c} = h
  # item = p ++ Enum.take(c, 1)
  # is_solution
  # gen = {item, 3..1//-1}
  # {_ign, rest} = Range.split(c, 1)
  # new_head = {p, rest}
  # q = [ new_head | tl(q) ]
  # q = [ gen | q ]

  def start(solution) do
    q = Children.init()
    IO.puts("QUEUE: #{inspect(q)}")
    {_, r} = hd(q)
    Solver.solve({q, solution, Range.size(r)})
  end
end
