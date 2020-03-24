defmodule OpenchatElixirWeb.RegisterUserCommandTest do
  alias OpenchatElixir.RegisterUserCommand
  alias OpenchatElixir.Entities.User

  use ExUnit.Case 
  import Mox

  setup do
    Mox.defmock(MockUserRepository, for: OpenchatElixir.UserRepository)
    :ok
  end

  test "passed UserRepository module is used to store the user" do
    user_to_register = %User{
      username: "clean.coder90",
      password: "vEry$ecure",
      about: "It's all about craft."
    }
    expect(MockUserRepository, :store, 1, fn ^user_to_register -> "stored_uuid" end)

    registered_user = RegisterUserCommand.run(user_to_register, MockUserRepository)

    assert registered_user == %{ user_to_register | id: "stored_uuid" }
    Mox.verify!
  end

end
