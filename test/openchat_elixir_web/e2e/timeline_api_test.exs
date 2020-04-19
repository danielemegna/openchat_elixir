defmodule OpenchatElixirWeb.E2E.TimelineApiTest do
  use OpenchatElixirWeb.ConnCase
  alias OpenchatElixirWeb.E2E.UsersApiTest

  test "timeline on unexisting user", %{conn: conn} do
    conn = get(conn, "/users/unexisting_id/timeline")
    assert text_response(conn, 404) == "User not found."
  end

  test "empty user timeline", %{conn: conn} do
    %{"id" => user_id} = UsersApiTest.register_user(conn, "any.username")

    conn = get(conn, "/users/#{user_id}/timeline")
    assert json_response(conn, 200) == []
  end

  test "post submit attempt with unexisting user", %{conn: conn} do
    conn = post(conn, "/users/unexisting_id/timeline", %{
      text: "Post text."
    })
    assert text_response(conn, 404) == "User not found."
  end

  test "submit post and fetch user timeline", %{conn: conn} do
    %{"id" => user_id} = UsersApiTest.register_user(conn, "any.username")

    response_body = submit_post(conn, user_id, "First user post.")

    assert Enum.count(Map.keys(response_body)) == 4
    assert Regex.match?(~r/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i, response_body["postId"])
    assert user_id == response_body["userId"]
    assert "First user post." == response_body["text"]
    assert Regex.match?(~r/^((19|20)[0-9][0-9])[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])[T]([01][0-9]|[2][0-3])[:]([0-5][0-9])[:]([0-5][0-9])Z$/i, response_body["dateTime"])

    %{ "postId" => firstPostId, "dateTime" => firstPostDateTime } = response_body
    %{ "postId" => secondPostId, "dateTime" => secondPostDateTime } = submit_post(conn, user_id, "Second user post.")

    conn = get(conn, "/users/#{user_id}/timeline")
    assert json_response(conn, 200) == [
      %{
        "postId" => secondPostId,
        "userId" => user_id,
        "text" => "Second user post.",
        "dateTime" => secondPostDateTime
      },
      %{
        "postId" => firstPostId,
        "userId" => user_id,
        "text" => "First user post.",
        "dateTime" => firstPostDateTime
      }
    ]
  end

  def submit_post(conn, user_id, text) do
    conn = post(conn, "/users/#{user_id}/timeline", %{ text: text })
    json_response(conn, 201)
  end

end
