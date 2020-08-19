defmodule OpenchatElixirWeb.E2E.FollowingsApiTest do
  use OpenchatElixirWeb.ConnCase
  alias OpenchatElixirWeb.E2E.UsersApiTest

  # POST /followings --> Create a following relationship between users.
  # GET /followings/{followerId}/followees --> Return users followed by a given user 
  
  # try to follow with an invalid uid
  # try to follow an invalid uid
  # try to follow again same user (400 "Following already exist.")

  test "get followees attempt with invalid user id", %{conn: conn} do
    conn = get(conn, "/followings/unexisting_id/followees")
    assert text_response(conn, 404) == "User not found."
  end

  test "get followees without any followings", %{conn: conn} do
    %{"id" => user_id} = UsersApiTest.register_user(conn, "any.username")
    conn = get(conn, "/followings/#{user_id}/followees")
    assert json_response(conn, 200) == []
  end

  test "follow and get followers (happy path)", %{conn: conn} do
    %{"id" => first_user_id} = UsersApiTest.register_user(conn, "first.username", "any", "About first user.")
    %{"id" => second_user_id} = UsersApiTest.register_user(conn, "second.username", "any", "About second user.")

    submit_following(conn, first_user_id, second_user_id)

    #conn = get(conn, "/followings/#{first_user_id}/followees")
    #assert json_response(conn, 200) == [
    #  %{
    #    "id" => second_user_id,
    #    "username" => "second.username",
    #    "about" => "About second user."
    #  }
    #]
  end

  def submit_following(conn, follower_id, followee_id) do
    conn = post(conn, "/followings", %{
      followerId: follower_id,
      followeeId: followee_id
    })
    assert text_response(conn, 201) == "Following created."
  end

end
