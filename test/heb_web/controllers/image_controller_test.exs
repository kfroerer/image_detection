defmodule HebWeb.ImageControllerTest do
  use HebWeb.ConnCase

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
      conn = post(conn, ~p"/images", %{"image_url" => "some uri", "label" => "some label"})

      assert %{"id" => id} =
               json_response(conn, 201)["response"]

      conn = get(conn, ~p"/images/#{id}")

      assert %{
               "id" => ^id,
               "label" => "some label",
               "uri" => "some uri"
             } = json_response(conn, 200)["response"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/images", image_url: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
