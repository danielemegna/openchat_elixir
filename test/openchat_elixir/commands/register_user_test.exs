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
    user_to_register = valid_user()
    assert {:ok, registered_user} = run_command(user_to_register)
    assert registered_user == %{ user_to_register | id: "stored.user.id" }
  end

  test "passed UserRepository module is used to store the user" do
    user_to_register = valid_user()
    expect(MockUserRepository, :store, 1, fn ^user_to_register -> "stored.user.id" end)

    run_command(user_to_register)

    Mox.verify!
  end

  test "register a users twice should return an error" do
    already_registered_user = %User{ valid_user() | username: "already.registered.username" }
    expect(MockUserRepository, :get_by_username, 1, fn "already.registered.username" -> already_registered_user end)

    assert {:username_already_used, nil} = run_command(already_registered_user)
    Mox.verify!
  end

  test "username cannot be empty or nil" do
    assert {:invalid_user_data, nil} = run_command(%User{ valid_user() | username: "" })
    assert {:invalid_user_data, nil} = run_command(%User{ valid_user() | username: nil })
  end

  test "password cannot be empty or nil" do
    assert {:invalid_user_data, nil} = run_command(%User{ valid_user() | password: "" })
    assert {:invalid_user_data, nil} = run_command(%User{ valid_user() | password: nil })
  end

  defp run_command(user) do
    RegisterUserCommand.run(user, MockUserRepository)
  end

  defp valid_user(), do:
    %User{
      username: "clean.coder90",
      password: "vEry$ecure",
      about: "It's all about craft."
    }

end
