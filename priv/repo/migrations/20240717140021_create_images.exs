defmodule Heb.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :uri, :string
      add :label, :string

      timestamps(type: :utc_datetime)
    end
  end
end
