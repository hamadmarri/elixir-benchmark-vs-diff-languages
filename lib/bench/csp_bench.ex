defmodule Bench.CspBench do
  def run do
    Benchee.run(
      %{
        # ":queue" => fn -> Csp.start([7, 7, 7, 7, 7, 7, 7, 9]) end,
        "list" => fn -> Csp.NormalList.start([7, 7, 7, 7, 7, 7, 7, 10]) end,
      },
      time: 30
    )
  end
end
