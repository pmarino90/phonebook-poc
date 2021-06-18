defmodule Phonebook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Phonebook.Repo,
      # Start the Telemetry supervisor
      PhonebookWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phonebook.PubSub},
      # Start the Endpoint (http/https)
      PhonebookWeb.Endpoint
      # Start a worker by calling: Phonebook.Worker.start_link(arg)
      # {Phonebook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phonebook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhonebookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
