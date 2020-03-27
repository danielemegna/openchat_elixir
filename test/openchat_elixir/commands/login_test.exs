defmodule OpenchatElixirWeb.LoginCommandTest do
  alias OpenchatElixir.LoginCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_username, fn _ -> nil end)
    :ok
  end

  test "do not authenticate with empty repository" do
    {result, logged_user} = LoginCommand.run("any", "any", MockUserRepository)

    assert :invalid_credentials == result
    assert nil == logged_user 
  end

  test "authenticate registered user" do
    registered_user = %User{
      username: "stored.user",
      password: "pa$$word",
      about: "any"
    }
    expect(MockUserRepository, :get_by_username, 1, fn "stored.user" -> registered_user end)

    {result, logged_user} = LoginCommand.run("stored.user", "pa$$word", MockUserRepository)

    assert :ok == result
    assert registered_user == logged_user 
    Mox.verify!
  end

  test "do not authenticate registered user with wrong password" do
    registered_user = %User{
      username: "stored.user",
      password: "pa$$word",
      about: "any"
    }
    expect(MockUserRepository, :get_by_username, 1, fn "stored.user" -> registered_user end)

    {result, logged_user} = LoginCommand.run("stored.user", "wrong", MockUserRepository)

    assert :invalid_credentials == result
    assert nil == logged_user 
    Mox.verify!
  end

end
