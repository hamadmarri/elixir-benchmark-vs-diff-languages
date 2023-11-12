defmodule Csp.NormalList.Solver do
  alias Csp.NormalList.Children

  def solve({q, _, stat}) when q == [] do
    IO.puts("q IS EMPTY!, QUITTING!, count: #{stat}")
    :exit
  end

  def solve({_, solution, _}) when solution == nil do
    :ok
  end

  def solve({q, solution, stat}) do
    # IO.puts("QUEUE: #{inspect(q)}")
    item = hd(q)

    # check if it is a solution?
    case is_solution?({item, solution}) do
      true ->
        IO.puts("FOUND A SOLUTION #{inspect(item, charlists: :as_list)}, count: #{stat}")
        solve({nil, nil, nil})

      false ->
        # if not, generate children from this item
        {q, stat} = Children.generate(tl(q), item, stat)
        solve({q, solution, stat})
    end
  end

  defp is_solution?({item, solution}) do
    item == solution
  end
end
