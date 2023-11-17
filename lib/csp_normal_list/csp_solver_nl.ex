defmodule Csp.NormalList.Solver do
  @compile {:inline, is_solution?: 2, generate: 3}

  @entropy 10
  @max_digit 10
  @rng [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

  def init() do
    # IO.puts("q INIT CHILDREN")
    # in the form [1], [2], ..
    Enum.map(@rng, &[&1])
  end

  def generate(q, parent_items, stat) do
    case length(parent_items) >= @max_digit do
      true ->
        {q, stat}

      false ->
        # IO.puts("GEN CHILDREN for #{inspect(parent_items)}")
        children = for c <- @rng, do: [c | parent_items]

        # add children to stack
        {children ++ q, stat + @entropy}
    end
  end

  def solve({q, solution, stat}) do
    # IO.puts("QUEUE: #{inspect(q)}")
    item = hd(q)

    # check if it is a solution?
    case is_solution?(item, solution) do
      true ->
        IO.puts("FOUND A SOLUTION #{inspect(item, charlists: :as_list)}, count: #{stat}")
        :ok

      false ->
        # if not, generate children from this item
        {q, stat} = generate(tl(q), item, stat)

        case q == [] do
          true ->
            IO.puts("q IS EMPTY!, QUITTING!, count: #{stat}")
            :exit

          false ->
            solve({q, solution, stat})
        end
    end
  end

  defp is_solution?(item, solution) do
    item == solution
  end
end
