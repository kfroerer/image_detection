defmodule Heb.Repo.Migrations.AddTags do
  use Ecto.Migration

  def change do
    alter table(:images) do
      add(:tags, {:array, :string})
    end
  end
end
