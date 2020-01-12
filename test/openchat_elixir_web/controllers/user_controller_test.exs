defmodule OpenchatElixirWeb.UserControllerTest do
  use OpenchatElixirWeb.ConnCase

  test "GET /users", %{conn: conn} do
    conn = get(conn, "/users")
    assert json_response(conn, 200) == []
  end

  test "POST /users", %{conn: conn} do
    request_body = %{
      username: "shady90",
      password: "secure",
      about: "About shady90."
    }

    conn = post(conn, "/users", request_body)

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
