defmodule HebWeb.ImageController do
  use HebWeb, :controller

  alias Heb.Images
  alias Heb.Images.Image

  action_fallback HebWeb.FallbackController

  def index(conn, %{"objects" => objects} = params) do
    text(conn, "This is working")
    IO.inspect(params)
    # TODO: search repo for records that have these tags.
  end

  def index(conn, _params) do
    images = Images.list_images()
    render(conn, :index, images: images)
  end

  def create(conn, %{"image" => image_params}) do
    # implement 3rd party API here
    with {:ok, %Image{} = image} <- Images.create_image(image_params) do
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
