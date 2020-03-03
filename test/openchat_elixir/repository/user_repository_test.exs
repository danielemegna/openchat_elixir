defmodule OpenchatElixirWeb.UserRepositoryTest do
  use ExUnit.Case 
  alias OpenchatElixir.UserRepository
  alias OpenchatElixir.Entities.User

  setup do
    UserRepository.start_link([])
    :ok
  end


  test "get user from empty repository" do
    users = UserRepository.get_all()
    assert users == []  
  end

  test "store and get user" do
    user = %User{
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }
    stored_id = UserRepository.store(user)
    users = UserRepository.get_all()

    assert users == [%User{
      id: stored_id,
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }]
  end

  test "in this repository users are stored in reverse order" do
    shady_user = %User{
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }
    shady_id = UserRepository.store(shady_user)
    maria_user = %User{
      username: "maria89",
      password: "supeR$3cure",
      about: "About maria89."
    }
    maria_id = UserRepository.store(maria_user)

    users = UserRepository.get_all()

    assert users == [
      %User{
        id: maria_id,
        username: "maria89",
        password: "supeR$3cure",
        about: "About maria89."
      },
      %User{
        id: shady_id,
        username: "shady90",
        password: "$3curePass",
        about: "About shady90."
      }
    ]
  end

end
