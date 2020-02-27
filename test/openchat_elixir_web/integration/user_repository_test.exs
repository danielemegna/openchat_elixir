defmodule OpenchatElixirWeb.UserRepositoryTest do
  use ExUnit.Case 
  alias OpenchatElixir.UserRepository
  alias OpenchatElixir.Entities.User

  setup do
    repository = UserRepository.start_link()
    %{repository: repository}
  end

  test "get user from empty repository", %{repository: repository} do
    users = UserRepository.get_all(repository)
    assert users == []  
  end

  test "store and get user", %{repository: repository} do
    user = %User{
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }
    stored_id = UserRepository.store(repository, user)
    users = UserRepository.get_all(repository)

    assert users == [%User{
      id: stored_id,
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }]
  end

  test "in this repository users are stored in reverse order", %{repository: repository} do
    shady_user = %User{
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }
    shady_id = UserRepository.store(repository, shady_user)
    maria_user = %User{
      username: "maria89",
      password: "supeR$3cure",
      about: "About maria89."
    }
    maria_id = UserRepository.store(repository, maria_user)

    users = UserRepository.get_all(repository)

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
