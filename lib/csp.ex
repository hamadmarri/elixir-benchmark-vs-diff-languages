defmodule Csp do
  use GenServer
  alias Csp.Children
  @timeout :timer.minutes(3)

  def start(solution) do
    IO.puts("CSP START --------------")
    q = Children.init()
    spin_solvers({q, solution, :queue.len(q)})
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    IO.puts("CSP END --------------")
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast({:spin_solvers_from, {pid, arg}}, state) do
    # IO.puts("CSP handle_cast from #{inspect(pid)}")
    spin_solvers(arg)
    {:noreply, state}
  end

  def spin_solvers_from(pid, {_q, _solution, _stat} = arg) do
    GenServer.cast(__MODULE__, {:spin_solvers_from, {pid, arg}})
  end

  def spin_solvers({q, solution, stat}) do
    # IO.puts("SPIN INIT #{inspect(q, charlists: :as_list)}")
    count = :queue.len(q)

    Enum.reduce(1..count, q, fn _, q ->
      e = [:queue.get(q)]
      q = :queue.drop(q)
      s = :queue.from_list(e)
      spin({s, solution, stat})
      q
    end)
  end

  defp spin(arg) do
    p = :poolboy.checkout(:solver)
    GenServer.cast(p, {:solve, arg})
  end
end
