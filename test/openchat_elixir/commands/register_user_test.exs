defmodule OpenchatElixirWeb.RegisterUserCommandTest do
  alias OpenchatElixir.RegisterUserCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_username, fn _ -> nil end)
    :ok
  end

  test "passed UserRepository module is used to store the user" do
    user_to_register = %User{
      username: "clean.coder90",
      password: "vEry$ecure",
      about: "It's all about craft."
    }
    expect(MockUserRepository, :store, 1, fn ^user_to_register -> "stored_uuid" end)

    {result, registered_user} = RegisterUserCommand.run(user_to_register, MockUserRepository)

    assert :ok == result
    assert registered_user == %{ user_to_register | id: "stored_uuid" }
    Mox.verify!
  end

  test "register a users twice should return an error" do
    already_registered_user = %User{
      username: "stored.user",
      password: "any",
      about: "any"
    }
    expect(MockUserRepository, :get_by_username, 1, fn "stored.user" -> already_registered_user end)

    {result, registered_user} = RegisterUserCommand.run(already_registered_user, MockUserRepository)

    assert :username_already_used == result
    assert nil == registered_user
    Mox.verify!
  end

end