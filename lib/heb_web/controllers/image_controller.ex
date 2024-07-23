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

  def create(conn, %{"image_url" => image_url, "detect_objects" => true} = params) do
    with {:ok, tags} <- Heb.Imagga.get_image_tags_by_url(image_url) do
      default_label = if not Enum.empty?(tags), do: hd(tags), else: "unknown label"
      label = Map.get(params, "label", default_label)
      {:ok, image} = Images.create_image(%{tags: tags, uri: image_url, label: label})
      handle_created_image(conn, image)
    else
      {:error, _err} ->
        conn
        |> put_status(:bad_request)
        |> put_view(HebWeb.ErrorJSON)
        |> render("400.json", [])
    end
  end

  def create(conn, %{"image_url" => image_url} = params) do
    label = Map.get(params, "label", "unknown_label")

    {:ok, image} = Images.create_image(%{uri: image_url, label: label})
    handle_created_image(conn, image)
  end

  def create(conn, %{"image_file" => file_path, "detect_objects" => true} = params) do
    tags = Heb.Imagga.get_image_tags_from_file(file_path)
    # function to get tags by url:
    #   - upload first, then tags w/upload_id
    text(conn, "encode working")
  end

  def create(conn, %{"image_file" => file} = params) do
    text(conn, "no objects detected")
  end

  def show(conn, %{"id" => id}) do
    image = Images.get_image!(id)
    render(conn, :show, image: image)
  end

  def handle_created_image(conn, image) do
    conn
    |> put_status(:created)
    |> put_resp_header("location", ~p"/images/#{image}")
    |> render(:show, image: image)
  end
end
