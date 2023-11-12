defmodule Csp.NormalList.Solver do
  alias Csp.NormalList.Children

  def solve({q, _, stat}) when q == [] do
    IO.puts("q IS EMPTY!, QUITTING!, count: #{stat}")
    :exit
  end

  def solve({_, solution, _}) when solution == nil do
    :ok
  end

  # def solve({_, _, stat}) when stat >= 10 do
  #   nil
  # end

  def solve({q, solution, stat}) do
    # IO.puts("QUEUE: #{inspect(Enum.to_list(q))}")

    item = Enum.at(q, 0)
    # IO.inspect(item)

    # check if it is a solution?
    case is_solution?({item, solution}) do
      true ->
        IO.puts("FOUND A SOLUTION #{inspect(item, charlists: :as_list)}, count: #{stat}")
        solve({nil, nil, nil})

      false ->
        # if not, generate children from this item
        {q, stat} = Children.generate(Enum.drop(q, 1), item, stat)
        solve({q, solution, stat})
    end
  end

  defp is_solution?({item, solution}) do
    item == solution
  end
end
