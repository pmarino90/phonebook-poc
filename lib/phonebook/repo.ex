defmodule Phonebook.Repo do
  use Ecto.Repo,
    otp_app: :phonebook,
    adapter: Ecto.Adapters.Postgres
end
