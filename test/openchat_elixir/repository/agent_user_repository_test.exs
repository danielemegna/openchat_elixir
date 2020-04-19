defmodule OpenchatElixirWeb.AgentUserRepositoryTest do
  use ExUnit.Case 
  alias OpenchatElixir.AgentUserRepository
  alias OpenchatElixir.Entities.User
  import OpenchatElixirWeb.Support.AssertionsHelper

  setup do
    AgentUserRepository.start_link([])
    :ok
  end


  test "get user from empty repository" do
    assert [] == AgentUserRepository.get_all()
    assert nil == AgentUserRepository.get_by_username("not_present")
    assert nil == AgentUserRepository.get_by_id("not_present")
  end

  test "store and get user" do
    user = %User{
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }

    stored_id = AgentUserRepository.store(user)
    assert_valid_uuid stored_id

    expected_stored_user = %User{
      id: stored_id,
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }

    assert expected_stored_user == AgentUserRepository.get_by_username("shady90")
    assert expected_stored_user == AgentUserRepository.get_by_id(stored_id)
    assert [expected_stored_user] == AgentUserRepository.get_all()
    assert nil == AgentUserRepository.get_by_username("not_present")
    assert nil == AgentUserRepository.get_by_id("not_present")
  end

  test "in this repository users are stored in reverse order" do
    shady_user = %User{
      username: "shady90",
      password: "$3curePass",
      about: "About shady90."
    }
    shady_id = AgentUserRepository.store(shady_user)
    maria_user = %User{
      username: "maria89",
      password: "supeR$3cure",
      about: "About maria89."
    }
    maria_id = AgentUserRepository.store(maria_user)

    users = AgentUserRepository.get_all()

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
