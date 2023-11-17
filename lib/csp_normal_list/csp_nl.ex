defmodule Csp.NormalList do
  alias Csp.NormalList.Solver

  def start(solution, times \\ 1) do
    Enum.each(1..times, fn _ ->
      :timer.tc(fn ->
        q = Solver.init()
        IO.puts("QUEUE: #{inspect(q)}")
        Solver.solve({q, solution, length(q)})
      end)
      |> IO.inspect()
    end)
  end
end
