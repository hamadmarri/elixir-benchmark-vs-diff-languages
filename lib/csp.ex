defmodule Csp do
  alias Csp.Children
  alias Csp.Solver

  def start(solution) do
    IO.puts("CSP START --------------")
    q = Children.init()
    arg = {q, solution, :queue.len(q)}
    cp = [{Solver, arg}]
    Supervisor.start_link(cp, strategy: :one_for_one)
    IO.puts("CSP END --------------")
  end
end
