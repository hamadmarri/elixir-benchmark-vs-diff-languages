defmodule Bench.CspBench do
  def run do
    Benchee.run(
      %{
        "list1" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list2" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list3" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list4" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list5" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list6" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list7" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list8" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list9" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end,
        # "list10" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 5, 10]) end
      },
      # warmup: 0,
      time: 5
    )
  end
end
