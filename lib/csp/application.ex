defmodule Csp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp poolboy_config do
    [
      name: {:local, :solver},
      worker_module: Csp.Solver,
      size: 9,
      max_overflow: 0
    ]
  end

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Csp.Worker.start_link(arg)
      # {Csp.Worker, arg}
      :poolboy.child_spec(:solver, poolboy_config())
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Csp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
