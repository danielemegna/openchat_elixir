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
      id: "shadyId",
      username: "shady90",
      about: "About shady90."
    }
    UserRepository.store(repository, user)

    users = UserRepository.get_all(repository)
    assert users == [user]
  end

  test "in this repository users are stored in reverse order", %{repository: repository} do
    shadyUser = %User{
      id: "shadyId",
      username: "shady90",
      about: "About shady90"
    }
    UserRepository.store(repository, shadyUser)
    mariaUser = %User{
      id: "mariaId",
      username: "maria89",
      about: "About maria89."
    }
    UserRepository.store(repository, mariaUser)

    users = UserRepository.get_all(repository)
    assert users == [mariaUser, shadyUser]
  end

end
