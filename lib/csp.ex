defmodule Csp do
  alias Csp.Children
  @timeout :timer.minutes(3)

  def start(solution) do
    IO.puts("CSP START --------------")
    q = Children.init()
    arg = {q, solution, :queue.len(q)}
    spin_solvers(arg)
    IO.puts("CSP END --------------")
  end

  defp spin_solvers(arg) do
    :poolboy.transaction(
      :solver,
      fn pid ->
        GenServer.cast(pid, {:solve, arg})
      end,
      @timeout
    )
  end
end
