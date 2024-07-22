defmodule HebWeb.ImageControllerTest do
  use HebWeb.ConnCase

  import Heb.ImagesFixtures

  alias Heb.Images.Image

  @create_attrs %{
    label: "some label",
    uri: "some uri"
  }
  @update_attrs %{
    label: "some updated label",
    uri: "some updated uri"
  }
  @invalid_attrs %{label: nil, uri: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all images", %{conn: conn} do
      conn = get(conn, ~p"/images")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create image" do
    test "renders image when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/images", image: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/images/#{id}")

      assert %{
               "id" => ^id,
               "label" => "some label",
               "uri" => "some uri"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/images", image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update image" do
    setup [:create_image]

    test "renders image when data is valid", %{conn: conn, image: %Image{id: id} = image} do
      conn = put(conn, ~p"/images/#{image}", image: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/images/#{id}")

      assert %{
               "id" => ^id,
               "label" => "some updated label",
               "uri" => "some updated uri"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn = put(conn, ~p"/images/#{image}", image: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete(conn, ~p"/images/#{image}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/images/#{image}")
      end
    end
  end

  defp create_image(_) do
    image = image_fixture()
    %{image: image}
  end
end
