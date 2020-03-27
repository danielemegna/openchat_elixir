defmodule OpenchatElixir.LoginCommand do
  alias OpenchatElixir.Entities.User

  def run(username, password, user_repository \\ OpenchatElixir.AgentUserRepository) do
    user_from_repository = user_repository.get_by_username(username)
    case(user_from_repository) do
      %User{ password: ^password } -> {:ok, user_from_repository}
      _ -> {:invalid_credentials, nil}
    end
  end

end
