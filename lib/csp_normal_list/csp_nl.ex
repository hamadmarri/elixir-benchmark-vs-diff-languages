defmodule Csp.NormalList do
  alias Csp.NormalList.Children
  alias Csp.NormalList.Solver

  def start(solution) do
    q = Children.init()
    IO.puts("QUEUE: #{inspect(Enum.to_list(q))}")
    Solver.solve({q, solution, Enum.count(q)})
  end

end
