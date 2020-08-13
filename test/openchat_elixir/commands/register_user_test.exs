defmodule OpenchatElixirWeb.RegisterUserCommandTest do
  alias OpenchatElixir.RegisterUserCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    stub(MockUserRepository, :get_by_username, fn _ -> nil end)
    stub(MockUserRepository, :store, fn _ -> "stored.user.id" end)
    :ok
  end

  test "returns stored user with result :ok" do
    user_to_register = %User{
      username: "clean.coder90",
      password: "vEry$ecure",
      about: "It's all about craft."
    }

    assert {:ok, registered_user} = RegisterUserCommand.run(user_to_register, MockUserRepository)
    assert registered_user == %{ user_to_register | id: "stored.user.id" }
  end

  test "passed UserRepository module is used to store the user" do
    user_to_register = %User{
      username: "clean.coder90",
      password: "vEry$ecure",
      about: "It's all about craft."
    }
    expect(MockUserRepository, :store, 1, fn ^user_to_register -> "stored.user.id" end)

    RegisterUserCommand.run(user_to_register, MockUserRepository)

    Mox.verify!
  end

  test "register a users twice should return an error" do
    already_registered_user = %User{
      username: "stored.user",
      password: "any",
      about: "any"
    }
    expect(MockUserRepository, :get_by_username, 1, fn "stored.user" -> already_registered_user end)

    assert {:username_already_used, nil} = RegisterUserCommand.run(already_registered_user, MockUserRepository)
    Mox.verify!
  end

  test "username cannot be empty or nil" do
    user_to_register = %User{ username: "", password: "any", about: "any" }
    assert {:invalid_user_data, nil} = RegisterUserCommand.run(user_to_register, MockUserRepository)
    user_to_register = %User{ username: nil, password: "any", about: "any" }
    assert {:invalid_user_data, nil} = RegisterUserCommand.run(user_to_register, MockUserRepository)
  end

  test "password cannot be empty or nil" do
    user_to_register = %User{ username: "any", password: "", about: "any" }
    assert {:invalid_user_data, nil} = RegisterUserCommand.run(user_to_register, MockUserRepository)
    user_to_register = %User{ username: "any", password: nil, about: "any" }
    assert {:invalid_user_data, nil} = RegisterUserCommand.run(user_to_register, MockUserRepository)
  end

end
