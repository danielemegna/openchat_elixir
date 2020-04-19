defmodule OpenchatElixirWeb.E2E.LoginApiTest do
  use OpenchatElixirWeb.ConnCase
  alias OpenchatElixirWeb.E2E.UsersApiTest

  test "login attempt with invalid credentials", %{conn: conn} do
    conn = post(conn, "/login", %{
      username: "invalid",
      password: "credentials"
    })
    response_text = text_response(conn, 404)
    assert response_text == "Invalid credentials."
  end

  test "register and login a user", %{conn: conn} do
    %{"id" => shady90_id} = UsersApiTest.register_user(conn, "shady90", "s3cure", "About shady90.")

    conn = post(conn, "/login", %{
      username: "shady90",
      password: "wrong"
    })
    response_text = text_response(conn, 404)
    assert response_text == "Invalid credentials."

    conn = post(conn, "/login", %{
      username: "shady90",
      password: "s3cure"
    })
    response_body = json_response(conn, 200)
    assert response_body == %{
      "id" => shady90_id,
      "username" => "shady90",
      "about" => "About shady90."
    }
  end

end
