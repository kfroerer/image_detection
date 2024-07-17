defmodule Heb.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :label, :string
    field :uri, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:uri, :label])
    |> validate_required([:uri, :label])
  end
end
