defmodule Heb.Repo do
  use Ecto.Repo,
    otp_app: :heb,
    adapter: Ecto.Adapters.Postgres
end
