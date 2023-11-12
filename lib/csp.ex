defmodule Csp do
  alias Csp.Children
  @timeout :timer.minutes(3)

  def start(solution) do
    IO.puts("CSP START --------------")
    q = Children.init()
    spin_solvers({q, solution, length(q)})
    IO.puts("CSP END --------------")
  end

  defp spin_solvers({q, solution, stat}) do
    IO.puts("SPIN INIT #{inspect(q, charlists: :as_list)}")
    count = stat
    Enum.reduce(1..count, q, fn _, q ->
      [e | q] = q
      spin({[e], solution, stat})
      q
    end)
  end

  defp spin(arg) do
    p = :poolboy.checkout(:solver, true, @timeout)
    GenServer.cast(p, {:solve, arg})
  end
end
