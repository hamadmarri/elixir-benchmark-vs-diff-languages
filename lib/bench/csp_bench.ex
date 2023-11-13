defmodule Bench.CspBench do
  def run do
    Benchee.run(
      %{
        "list1" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 10]) end,
        "list2" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 10]) end,
        "list3" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 10]) end,
        "list4" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 10]) end,
      },
      # warmup: 0,
      time: 5
    )
  end
end
