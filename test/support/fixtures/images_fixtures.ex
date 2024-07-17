defmodule Heb.ImagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Heb.Images` context.
  """

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        label: "some label",
        uri: "some uri"
      })
      |> Heb.Images.create_image()

    image
  end
end
