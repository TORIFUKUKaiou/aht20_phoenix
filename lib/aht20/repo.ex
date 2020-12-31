defmodule Aht20.Repo do
  use Ecto.Repo,
    otp_app: :aht20,
    adapter: Ecto.Adapters.Postgres
end
