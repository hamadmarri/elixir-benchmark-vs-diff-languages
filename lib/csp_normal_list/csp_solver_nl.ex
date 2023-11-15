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
    head = hd(q)
    {parent, children_r} = head
    children = Enum.take(children_r, 1)
    item = parent ++ children

    # IO.puts("ITEM: #{inspect(item)}")

    solve_helper({q, solution, parent, item, children, children_r, stat})
  end

  defp solve_helper({q, solution, _parent, _item, children, _children_r, stat})
       when children == [] do
    solve({tl(q), solution, stat})
  end

  defp solve_helper({q, solution, parent, item, _children, children_r, stat}) do
    # check if it is a solution?
    case is_solution?({item, solution}) do
      true ->
        IO.puts("FOUND A SOLUTION #{inspect(item, charlists: :as_list)}, count: #{stat}")
        solve({nil, nil, nil})

      false ->
        # if not, generate children from this item
        {q, stat} = Children.generate(q, parent, item, children_r, stat)
        solve({q, solution, stat})
    end
  end

  defp is_solution?({item, solution}) do
    item == solution
  end
end
