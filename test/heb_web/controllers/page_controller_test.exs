defmodule HebWeb.PageControllerTest do
  use HebWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert json_response(conn, 200)["data"] == []
  end
end
