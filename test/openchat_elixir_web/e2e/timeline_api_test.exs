defmodule OpenchatElixirWeb.E2E.TimelineApiTest do
  use OpenchatElixirWeb.ConnCase

  test "timeline on unexisting user", %{conn: conn} do
    conn = get(conn, "/users/unexisting_id/timeline")
    assert text_response(conn, 404) == "User not found."
  end

  test "empty user timeline", %{conn: conn} do
    conn = post(conn, "/users", %{
      username: "shady90",
      password: "secure",
      about: "About shady90."
    })
    response_body = json_response(conn, 201) 
    user_id = response_body["id"]

    conn = get(conn, "/users/#{user_id}/timeline")
    assert json_response(conn, 200) == []
  end

end
