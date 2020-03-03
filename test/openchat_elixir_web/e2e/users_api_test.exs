defmodule OpenchatElixirWeb.E2E.UsersApiTest do
  use OpenchatElixirWeb.ConnCase

  test "get users from /users endpoint on new empty application", %{conn: conn} do
    conn = get(conn, "/users")
    assert json_response(conn, 200) == []
  end

  test "register and get users from /users endpoint", %{conn: conn} do
    conn = post(conn, "/users", %{
      username: "shady90",
      password: "secure",
      about: "About shady90."
    })
    response_body = json_response(conn, 201) 
    assert Enum.count(Map.keys(response_body)) == 3
    assert Regex.match?(~r/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i, response_body["id"])
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

  @tag :skip 
  test "register a users twice should return an error", %{conn: conn} do
    conn = post(conn, "/users", %{
      username: "shady90",
      password: "secure",
      about: "About shady90."
    })
    response_body = json_response(conn, 201)

    conn = post(conn, "/users", %{
      username: "shady90",
      password: "any",
      about: "any"
    })
    response_text = text_response(conn, 400)
    assert response_text == "Username already in use."
  end
end
