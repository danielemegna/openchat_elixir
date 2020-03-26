defmodule OpenchatElixirWeb.E2E.LoginApiTest do
  use OpenchatElixirWeb.ConnCase

  test "login attempt with invalid credentials", %{conn: conn} do
    conn = post(conn, "/login", %{
      username: "invalid",
      password: "credentials"
    })
    response_text = text_response(conn, 404)
    assert response_text == "Invalid credentials."
  end

end
