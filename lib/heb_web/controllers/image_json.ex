defmodule HebWeb.ImageJSON do
  alias Heb.Images.Image

  @doc """
  Renders a list of images.
  """
  def index(%{images: images}) do
    %{data: for(image <- images, do: data(image))}
  end

  @doc """
  Renders a single image.
  """
  def show(%{image: image}) do
    %{response: data(image)}
  end

  defp data(%Image{} = image) do
    %{
      id: image.id,
      uri: image.uri,
      label: image.label,
      tags: image.tags
    }
  end
end
