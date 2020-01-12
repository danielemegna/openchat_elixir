defmodule OpenchatElixirWeb.UserControllerTest do
  use OpenchatElixirWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/users")
    assert json_response(conn, 200) == []
  end
end
