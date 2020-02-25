defmodule OpenchatElixirWeb.E2E.UsersApiTest do
  use OpenchatElixirWeb.ConnCase

  test "register and get users from /users endpoint", %{conn: conn} do
    conn = get(conn, "/users")
    assert json_response(conn, 200) == []

    conn = post(conn, "/users", %{
      username: "shady90",
      password: "secure",
      about: "About shady90."
    })

    response_body = json_response(conn, 201) 
    assert response_body |> Map.keys |> Enum.count == 3
    assert %{
      "id" => a_uuid,
      "username" => "shady90",
      "about" => "About shady90."
    } = response_body
    assert Regex.match?(~r/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i, a_uuid)
  end

end
