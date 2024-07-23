defmodule HebWeb.ImageController do
  use HebWeb, :controller

  alias Heb.Images
  alias Heb.Images.Image

  action_fallback HebWeb.FallbackController

  def index(conn, %{"objects" => objects}) do
    query_tags = String.split(objects, ",")
    images = Images.find_matching_images(query_tags)
    render(conn, :index, images: images)
  end

  def index(conn, _params) do
    images = Images.list_images()
    render(conn, :index, images: images)
  end

  def create(conn, %{"image_url" => image_url}) do
    tags = Heb.Imagga.get_image_tags_by_url(image_url)

    if not Enum.empty?(tags) do
      {:ok, image} = Images.create_image(%{tags: tags, uri: image_url, label: hd(tags)})

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/images/#{image}")
      |> render(:show, image: image)
    end
  end

  def show(conn, %{"id" => id}) do
    image = Images.get_image!(id)
    render(conn, :show, image: image)
  end
end
