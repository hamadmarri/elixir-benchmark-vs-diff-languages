defmodule Csp.NormalList do
  alias Csp.NormalList.Children
  alias Csp.NormalList.Solver

  def start(solution) do
    q = Children.init()
    IO.puts("QUEUE: #{inspect(q)}")
    Solver.solve({q, solution, length(q)})
  end

end
