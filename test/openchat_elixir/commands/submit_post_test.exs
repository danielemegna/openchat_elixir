defmodule OpenchatElixirWeb.SubmitPostCommandTest do
  alias OpenchatElixir.SubmitPostCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_id, fn _ -> nil end)
    :ok
  end

  test "user not found error" do
    {result, post} = SubmitPostCommand.run("any", "any", MockUserRepository)

    assert :user_not_found == result
    assert nil == post 
  end

  test "returns submitted post" do
    registered_user = %User{
      id: "registered.user.id",
      username: "any",
      password: "any",
      about: "any"
    }
    expect(MockUserRepository, :get_by_id, 1, fn "registered.user.id" -> registered_user end)

    {result, post} = SubmitPostCommand.run("registered.user.id", "Post text here.", MockUserRepository)

    assert :ok == result
    assert Regex.match?(~r/^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$/i, post.id)
    assert "registered.user.id" == post.user_id
    assert "Post text here." == post.text
    assert post.datetime != nil
    assert DateTime.utc_now() >= post.datetime
  end

end
