defmodule OpenchatElixirWeb.GetUserTimelineCommandTest do
  alias OpenchatElixir.GetUserTimelineCommand
  alias OpenchatElixir.Entities.{User,Post}

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_id, fn user_id -> case user_id do
      "registered.user.id" -> %User{ id: user_id, username: "any", password: "any", about: "any" }
      _ -> nil
    end end)
    stub(MockPostRepository, :get_by_userid, fn _ -> [] end)
    :ok
  end

  test "user not found error" do
    {result, posts} = GetUserTimelineCommand.run("not.registered", MockUserRepository, MockPostRepository)

    assert :user_not_found == result
    assert nil == posts 
  end

  test "user without posts" do
    {result, posts} = GetUserTimelineCommand.run("registered.user.id", MockUserRepository, MockPostRepository)

    assert :ok == result
    assert [] == posts 
  end

  test "return posts stored in repository" do
    stored_user_posts = [
      %Post{
        id: "an-id",
        user_id: "registered.user.id", 
        text: "First post text.", 
        datetime: DateTime.utc_now() 
      },
      %Post{
        id: "another-id",
        user_id: "registered.user.id", 
        text: "Second post text.", 
        datetime: DateTime.utc_now() 
      }
    ]
    expect(MockPostRepository, :get_by_userid, 1, fn "registered.user.id" -> stored_user_posts end)

    {result, posts} = GetUserTimelineCommand.run("registered.user.id", MockUserRepository, MockPostRepository)

    assert :ok == result
    assert stored_user_posts == posts 
  end

end
