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
    conn = do_registration_post(conn, "shady90", "any", "any")

    response_text = text_response(conn, 400)
    assert response_text == "Username already in use."
  end

  test "cannot register with empty username or password", %{conn: conn} do
    conn = do_registration_post(conn, "shady90", "", "any")
    response_text = text_response(conn, 400)
    assert response_text == "Username and password cannot be empty."

    conn = do_registration_post(conn, "", "password", "any")
    response_text = text_response(conn, 400)
    assert response_text == "Username and password cannot be empty."
  end

  def register_user(conn, username, password \\ "anyPassword", about \\ "Any about.") do
    conn
    |> do_registration_post(username, password, about)
    |> json_response(201)
  end

  defp do_registration_post(conn, username, password, about) do
    post(conn, "/users", %{
      username: username,
      password: password,
      about: about
    })
  end

end
