defmodule Csp.Solver do
  use GenServer
  alias Csp.Children

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl GenServer
  def init(_) do
    IO.puts("Solver START #{inspect(self())} --------------")
    {:ok, nil}
  end

  @impl GenServer
  def handle_cast({:solve, arg = {q, _solution, _stat}}, state) do
    IO.puts("handling #{inspect(q, charlists: :as_list)}")
    solve(arg)
    {:noreply, state}
  end

  defp exit_with(:success, {item, stat}) do
    IO.puts(
      "FOUND A SOLUTION from #{inspect(self())} " <>
        "#{inspect(item, charlists: :as_list)}, count: #{stat}"
    )

    :poolboy.checkin(:solver, self())
    :ok
  end

  defp exit_with(:fail, _) do
    :poolboy.checkin(:solver, self())
    :fail
  end

  defp solve({q, _, stat}) when q == [] do
    IO.puts("q IS EMPTY!, QUITTING!, #{inspect(self())} count: #{stat}")
    exit_with(:fail, nil)
  end

  defp solve({q, solution, stat}) do
    # IO.puts("QUEUE: #{inspect(q)}")
    {item, q} = pop_item(q)

    # check if it is a solution?
    case is_solution?({item, solution}) do
      true ->
        exit_with(:success, {item, stat})

      false ->
        # if not, generate children from this item
        {q, stat} = Children.generate(q, item, stat)
        solve({q, solution, stat})
    end
  end

  defp is_solution?({item, solution}) do
    item == solution
  end

  defp pop_item(q) do
    [item | q] = q
    # IO.puts("SOLVE: #{inspect(item, charlists: :as_list)}")
    {item, q}
  end
end
