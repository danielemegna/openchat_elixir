defmodule OpenchatElixirWeb.SubmitPostCommandTest do
  alias OpenchatElixir.SubmitPostCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockPostRepository, :store, fn _ -> "stored.post.id" end)
    stub(MockUserRepository, :get_by_id, fn user_id -> case user_id do
      "registered.user.id" -> %User{ id: user_id, username: "any", password: "any", about: "any" }
      _ -> nil
    end end)
    :ok
  end

  test "user not found error" do
    {result, post} = SubmitPostCommand.run("any", "any", MockUserRepository, MockPostRepository)

    assert :user_not_found == result
    assert nil == post 
  end

  test "returns submitted post" do
    {result, post} = SubmitPostCommand.run("registered.user.id", "Post text here.", MockUserRepository, MockPostRepository)

    assert :ok == result
    assert "stored.post.id" == post.id
    assert "registered.user.id" == post.user_id
    assert "Post text here." == post.text
    assert post.datetime != nil
    assert DateTime.utc_now() >= post.datetime
  end

  test "passed repository is used to store the post" do
    expect(MockPostRepository, :store, 1, fn post ->
      assert nil == post.id
      assert "registered.user.id" == post.user_id
      assert "Post text." == post.text
      assert post.datetime != nil
      assert DateTime.utc_now() >= post.datetime
      "stored.post.id"
    end)

    SubmitPostCommand.run("registered.user.id", "Post text.", MockUserRepository, MockPostRepository)

    Mox.verify!
  end

end
