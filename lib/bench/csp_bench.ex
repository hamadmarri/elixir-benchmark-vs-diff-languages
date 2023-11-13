defmodule Bench.CspBench do
  def run do
    Benchee.run(
      %{
        "list" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 10]) end,
      },
      # warmup: 0,
      time: 5
    )
  end
end
