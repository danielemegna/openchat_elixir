defmodule OpenchatElixirWeb.GetUserTimelineCommandTest do
  alias OpenchatElixir.GetUserTimelineCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_id, fn _ -> nil end)
    :ok
  end

  test "user not found error" do
    {result, posts} = GetUserTimelineCommand.run("any", MockUserRepository)

    assert :user_not_found == result
    assert nil == posts 
  end

  test "user without posts" do
    stored_user = %User{
      id: "stored-user-id",
      username: "stored.user",
      password: "any",
      about: "any"
    }
    expect(MockUserRepository, :get_by_id, 1, fn "stored-user-id" -> stored_user end)
    {result, posts} = GetUserTimelineCommand.run("stored-user-id", MockUserRepository)

    assert :ok == result
    assert [] == posts 
  end

end
