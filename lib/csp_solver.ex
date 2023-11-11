defmodule Csp.Solver do
  use Task
  alias Csp.Children

  def start_link(arg) do
    IO.puts("Solver START --------------")
    Task.start_link(__MODULE__, :solve, [arg])
  end

  def solve({q, _, stat})
      when q == {[], []} do
    IO.puts("q IS EMPTY!, QUITTING!, count: #{stat}")
    :exit
  end

  def solve({q, solution, stat}) do
    # IO.puts("QUEUE: #{inspect(:queue.to_list(q))}")
    {item, q} = pop_item(q)

    # check if it is a solution?
    case is_solution?({item, solution}) do
      true ->
        IO.puts("FOUND A SOLUTION "
          <> "#{inspect(item, charlists: :as_list)}, count: #{stat}")

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
    item = :queue.get(q)
    q = :queue.drop(q)
    # IO.puts("SOLVE: #{inspect(item, charlists: :as_list)}")
    {item, q}
  end
end
