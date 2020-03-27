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

  test "register and login a user", %{conn: conn} do
    conn = post(conn, "/users", %{
      username: "shady90",
      password: "s3cure",
      about: "About shady90."
    })
    response_body = json_response(conn, 201) 
    shady90_id = response_body["id"]

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
