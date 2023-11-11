defmodule Csp do
  alias Csp.Children
  alias Csp.Solver

  def start(solution) do
    q = Children.init()
    Solver.solve({q, solution, :queue.len(q)})
  end
end
