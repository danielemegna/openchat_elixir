defmodule OpenchatElixirWeb.E2E.UsersApiTest do
  use OpenchatElixirWeb.ConnCase
  import OpenchatElixirWeb.Support.AssertionsHelper

  test "get users from /users endpoint on new empty application", %{conn: conn} do
    conn = get(conn, "/users")
    assert json_response(conn, 200) == []
  end

  test "register and get users from /users endpoint", %{conn: conn} do
    response_body = register_user(conn, "shady90", "secure", "About shady90.")

    assert Enum.count(Map.keys(response_body)) == 3
    assert_valid_uuid response_body["id"]
    assert response_body["username"] == "shady90"
    assert response_body["about"] == "About shady90."
    shady90_id = response_body["id"]

    conn = get(conn, "/users")
    response_body = json_response(conn, 200) 
    assert response_body == [
      %{
        "id" => shady90_id,
        "username" => "shady90",
        "about" => "About shady90."
      }
    ]
  end

  test "register a users twice should return an error", %{conn: conn} do
    register_user(conn, "shady90", "secure", "About shady90.")
    conn = post(conn, "/users", %{
      username: "shady90",
      password: "any",
      about: "any"
    })
    response_text = text_response(conn, 400)
    assert response_text == "Username already in use."
  end

  def register_user(conn, username, password \\ "anyPassword", about \\ "Any about.") do
    conn = post(conn, "/users", %{
      username: username,
      password: password,
      about: about
    })
    json_response(conn, 201)
  end

end
