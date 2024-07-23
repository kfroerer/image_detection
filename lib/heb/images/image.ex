defmodule Heb.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:label, :uri, :tags]}
  @type t :: %__MODULE__{}

  schema "images" do
    field :label, :string
    field :uri, :string
    field :tags, {:array, :string}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:uri, :label, :tags])
    |> validate_required([:uri, :label])
  end
end
