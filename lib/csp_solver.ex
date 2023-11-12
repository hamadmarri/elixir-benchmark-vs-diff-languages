defmodule Csp.Solver do
  use GenServer
  alias Csp.Children

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl GenServer
  def init(_) do
    # IO.puts("Solver START #{inspect(self())} --------------")
    {:ok, nil}
  end

  @impl GenServer
  def handle_cast({:solve, arg = {q, _solution, _stat}}, state) do
    # IO.puts("solver #{inspect(self())} HANDLING #{inspect(q, charlists: :as_list)}")
    solve(arg)
    {:noreply, state}
  end

  defp exit_with(:success, {item, stat}) do
    IO.puts(
      "----------- FOUND A SOLUTION from #{inspect(self())} " <>
        "#{inspect(item, charlists: :as_list)}, count: #{stat}"
    )

    :poolboy.checkin(:solver, self())
    {:ok, :success}
  end

  defp exit_with(:fail, _) do
    :poolboy.checkin(:solver, self())
    {:ok, :fail}
  end

  defp exit_with(:continue, _) do
    :poolboy.checkin(:solver, self())
    {:ok, :continue}
  end

  defp solve({q, _, stat})
       when q == {[], []} do
    IO.puts("q IS EMPTY!, QUITTING!, #{inspect(self())} count: #{stat}")
    exit_with(:fail, nil)
  end

  defp solve({q, solution, stat}) do
    # IO.puts("QUEUE: #{inspect(:queue.to_list(q))}")
    {item, q} = pop_item(q)

    # check if it is a solution?
    case is_solution?({item, solution}) do
      true ->
        exit_with(:success, {item, stat})

      false ->
        # if not, generate children from this item
        {q, stat} = Children.generate(q, item, stat)

        case :queue.is_empty(q) do
          true ->
            exit_with(:fail, nil)

          false ->
            Csp.spin_solvers_from(self(), {q, solution, stat})
            exit_with(:continue, nil)
        end
    end
  end

  defp is_solution?({item, solution}) do
    item == solution
  end

  defp pop_item(q) do
    item = :queue.get(q)
    q = :queue.drop(q)
    # IO.puts("SOLVE: #{inspect(item, charlists: :as_list)}")
    {item, q}
  end
end
